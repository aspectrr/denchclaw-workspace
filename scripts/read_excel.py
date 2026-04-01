import pandas as pd

# Read all sheets from the Excel file
excel_file = pd.ExcelFile('1774893959659-elastic_forum_leads.xlsx')

for sheet_name in excel_file.sheet_names:
    print(f'=== {sheet_name} ===')
    df = pd.read_excel(excel_file, sheet_name=sheet_name)
    print(df.to_csv(index=False))
    print()