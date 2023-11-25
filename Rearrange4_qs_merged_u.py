import pandas as pd

# 读取第一个CSV文件
df1 = pd.read_csv('export/t/urnew.csv')

# 读取第二个CSV文件
df2 = pd.read_csv('export/t/uqnew.csv')

# 合并两个DataFrame，将df2合并到df1的右侧
merged_df = pd.concat([df1, df2], axis=1)

# 保存合并后的DataFrame为新的CSV文件
merged_df.to_csv('export/t/u.csv', index=False)
