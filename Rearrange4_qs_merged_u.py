import pandas as pd

# Reading the first CSV file
df1 = pd.read_csv('export/t/urnew_modified.csv')

# Reading the second CSV file
df2 = pd.read_csv('export/t/uqnew_modified.csv')

# Merging the two DataFrames, appending df2 to the right side of df1
merged_df = pd.concat([df1, df2], axis=1)

# Saving the merged DataFrame to a new CSV file
merged_df.to_csv('export/t/u.csv', index=False)
