#!/usr/bin/env python3
"""
LinkedIn Profile Finder for Reddit Leads

This script helps find LinkedIn profiles for Reddit users who posted about
ELK/Elasticsearch issues, enabling multi-channel outreach.

Usage:
    python find_linkedin_profiles.py --reddit-user <username>
    python find_linkedin_profiles.py --reddit-url <post_url>
    python find_linkedin_profiles.py --batch-file <leads.json>

Requirements:
    - linkedin-mcp server configured
    - reddit-mcp server configured (optional, for username extraction)
    - web_search tool access (for discovery)
"""

import argparse
import json
import sys
from typing import List, Dict, Optional
import subprocess


def extract_username_from_reddit_url(url: str) -> Optional[str]:
    """Extract Reddit username from a post or comment URL."""
    # URL format: https://www.reddit.com/r/subreddit/comments/xxxxx/post_title/
    # or: https://www.reddit.com/user/username
    import re
    
    # Try to match /user/username pattern
    user_match = re.search(r'reddit\.com/user/([^/]+)', url)
    if user_match:
        return user_match.group(1)
    
    # Try to match /u/username pattern
    user_match = re.search(r'reddit\.com/u/([^/]+)', url)
    if user_match:
        return user_match.group(1)
    
    # Extract post ID from /r/subreddit/comments/xxxxx/ format
    post_match = re.search(r'/comments/([a-z0-9]+)/', url)
    if post_match:
        post_id = post_match.group(1)
        # Return post ID so we can look it up via Reddit MCP
        return f"post:{post_id}"
    
    return None


def get_reddit_username_from_post_id(post_id: str) -> Optional[str]:
    """
    Use Reddit MCP to get username from post ID.
    This would need to be called via the MCP tool.
    """
    # This is a placeholder - actual implementation would call reddit_get_post
    # and extract the author from the response
    return None


def search_linkedin_by_name(name: str, keywords: str = "elasticsearch elk devops") -> List[Dict]:
    """
    Search LinkedIn for profiles matching a name + keywords.
    
    Args:
        name: Person's name or Reddit username
        keywords: Additional search terms to narrow results
        
    Returns:
        List of potential LinkedIn profile matches
    """
    # This would call the linkedin-mcp search_people tool
    # For now, return search query suggestions
    search_queries = [
        f"site:linkedin.com/in/ \"{name}\" {keywords}",
        f"site:linkedin.com/in/ \"{name}\" elasticsearch",
        f"site:linkedin.com/in/ \"{name}\" devops engineer",
    ]
    
    return [{"query": q, "source": "linkedin_search"} for q in search_queries]


def find_profile_by_reddit_user(reddit_username: str, post_title: str = "") -> Dict:
    """
    Attempt to find LinkedIn profile for a Reddit user.
    
    Strategy:
        1. Search LinkedIn with username + context keywords
        2. Search for common name variations
        3. Look for GitHub profile (often linked in Reddit bio)
        4. Check if Reddit bio has direct LinkedIn link
        
    Args:
        reddit_username: Reddit username (without u/)
        post_title: Context about their post (helps with keyword search)
        
    Returns:
        Dict with profile info or search suggestions
    """
    result = {
        "reddit_username": reddit_username,
        "post_title": post_title,
        "linkedin_found": False,
        "linkedin_url": None,
        "confidence": 0,
        "search_queries": [],
        "notes": []
    }
    
    # Extract keywords from post title
    keywords = "elasticsearch elk devops"
    if post_title:
        # Add relevant keywords from post
        if any(word in post_title.lower() for word in ["splunk", "migrate", "migration"]):
            keywords += " splunk migration"
        if any(word in post_title.lower() for word in ["logstash", "pipeline"]):
            keywords += " logstash pipeline"
        if any(word in post_title.lower() for word in ["kibana", "dashboard"]):
            keywords += " kibana"
        if any(word in post_title.lower() for word in ["security", "soc", "siem"]):
            keywords += " security soc siem"
    
    # Generate search queries
    result["search_queries"] = [
        {
            "query": f"site:linkedin.com/in/ {reddit_username} {keywords}",
            "method": "web_search",
            "rationale": "Direct search for username on LinkedIn"
        },
        {
            "query": f"site:linkedin.com/in/ \"{reddit_username}\"",
            "method": "web_search",
            "rationale": "Exact match search"
        },
        {
            "query": f"{reddit_username} site:github.com",
            "method": "web_search", 
            "rationale": "Find GitHub profile (often links to LinkedIn)"
        }
    ]
    
    result["notes"].append(
        "Reddit usernames rarely match LinkedIn directly. "
        "Look for GitHub profile first, then cross-reference."
    )
    
    result["notes"].append(
        "Alternative: Reply to their Reddit post first, then ask for LinkedIn "
        "in a DM after establishing rapport."
    )
    
    return result


def process_lead_file(filepath: str) -> List[Dict]:
    """Process a JSON file of leads and find LinkedIn profiles."""
    with open(filepath, 'r') as f:
        leads = json.load(f)
    
    results = []
    for lead in leads:
        reddit_url = lead.get('url', '')
        post_title = lead.get('title', '')
        
        username = extract_username_from_reddit_url(reddit_url)
        if username:
            # Handle post ID format
            if username.startswith('post:'):
                post_id = username.replace('post:', '')
                profile = {
                    "reddit_post_id": post_id,
                    "reddit_url": reddit_url,
                    "post_title": post_title,
                    "note": "Post ID extracted. Use Reddit MCP (reddit_get_post) to get author username, then search LinkedIn.",
                    "linkedin_search_queries": generate_search_queries_from_post(post_title)
                }
            else:
                profile = find_profile_by_reddit_user(username, post_title)
            
            profile['lead_data'] = lead
            results.append(profile)
        else:
            # Still create a result with search suggestions
            results.append({
                "reddit_url": reddit_url,
                "post_title": post_title,
                "note": "Could not extract username. Manual review needed.",
                "linkedin_search_queries": generate_search_queries_from_post(post_title)
            })
    
    return results


def generate_search_queries_from_post(post_title: str) -> List[Dict]:
    """Generate LinkedIn search queries based on post content."""
    keywords = "elasticsearch elk devops"
    
    if post_title:
        if any(word in post_title.lower() for word in ["splunk", "migrate", "migration"]):
            keywords += " splunk migration"
        if any(word in post_title.lower() for word in ["logstash", "pipeline"]):
            keywords += " logstash pipeline"
        if any(word in post_title.lower() for word in ["kibana", "dashboard"]):
            keywords += " kibana"
        if any(word in post_title.lower() for word in ["security", "soc", "siem"]):
            keywords += " security soc siem"
        if any(word in post_title.lower() for word in ["kubernetes", "k8s", "helm"]):
            keywords += " kubernetes"
        if any(word in post_title.lower() for word in ["tls", "ssl", "cert"]):
            keywords += " security"
    
    return [
        {
            "query": f"site:linkedin.com/in/ {keywords}",
            "method": "web_search",
            "rationale": "Find LinkedIn profiles mentioning these ELK keywords"
        },
        {
            "query": f"site:linkedin.com/in/ \"elasticsearch\" \"engineer\"",
            "method": "linkedin_mcp",
            "rationale": "Search LinkedIn directly for Elastic engineers"
        }
    ]


def generate_outreach_priority_list(leads: List[Dict]) -> List[Dict]:
    """
    Prioritize leads for outreach based on:
        - Pain point severity
        - Likelihood of being a decision maker
        - Recentness of post
    """
    prioritized = []
    
    for lead in leads:
        score = 0
        reasons = []
        
        title = lead.get('title', '').lower()
        
        # Pain severity indicators
        if any(word in title for word in ['lost', 'crash', 'outage', 'broken', 'fail']):
            score += 10
            reasons.append("Critical pain point (data loss/outage)")
        
        if any(word in title for word in ['production', 'prod', 'mission critical']):
            score += 8
            reasons.append("Production environment")
        
        if 'terabyte' in title or 'tb' in title:
            score += 5
            reasons.append("Large scale (TBs of data)")
        
        # Decision maker indicators
        if any(word in title for word in ['migration', 'architect', 'design']):
            score += 3
            reasons.append("Strategic/leadership topic")
        
        prioritized.append({
            **lead,
            "priority_score": score,
            "priority_reasons": reasons
        })
    
    return sorted(prioritized, key=lambda x: x['priority_score'], reverse=True)


def main():
    parser = argparse.ArgumentParser(
        description='Find LinkedIn profiles for Reddit leads'
    )
    parser.add_argument(
        '--reddit-user', 
        help='Reddit username to search for'
    )
    parser.add_argument(
        '--reddit-url',
        help='Reddit post URL to extract username from'
    )
    parser.add_argument(
        '--batch-file',
        help='JSON file with leads to process'
    )
    parser.add_argument(
        '--output',
        '-o',
        default='linkedin_prospects.json',
        help='Output file for results'
    )
    
    args = parser.parse_args()
    
    results = []
    
    if args.reddit_user:
        result = find_profile_by_reddit_user(args.reddit_user)
        results.append(result)
        
    elif args.reddit_url:
        username = extract_username_from_reddit_url(args.reddit_url)
        if username:
            result = find_profile_by_reddit_user(username)
            results.append(result)
        else:
            print(f"Could not extract username from URL: {args.reddit_url}")
            sys.exit(1)
            
    elif args.batch_file:
        results = process_lead_file(args.batch_file)
        
    else:
        parser.print_help()
        sys.exit(1)
    
    # Save results
    with open(args.output, 'w') as f:
        json.dump(results, f, indent=2)
    
    print(f"Results saved to {args.output}")
    print(f"Processed {len(results)} leads")
    
    # Print summary
    for r in results:
        print(f"\n--- {r.get('reddit_username', 'Unknown')} ---")
        for query in r.get('search_queries', []):
            print(f"  Search: {query['query']}")
        for note in r.get('notes', []):
            print(f"  Note: {note}")


if __name__ == '__main__':
    main()
