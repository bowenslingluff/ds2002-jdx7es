import sys
import pandas as pd


if len(sys.argv) != 3:
	print("Usage: python clean_csv.py <input_filename.csv> <output_filename.csv>")
	sys.exit(1) 

csv_filename = sys.argv[1]
output_filename = sys.argv[2]

df = pd.read_csv(csv_filename)
print(f"Row count in original DataFrame: {len(df)}")

df_cleaned = df.dropna()
print(f"Row count after removing null records: {len(df)}")

df_cleaned = df_cleaned.drop_duplicates()
print(f"Row count after removing duplicate records: {len(df)}")

df_cleaned.to_csv(output_filename)
print(f"Cleaned file saved as: {output_filename}")
