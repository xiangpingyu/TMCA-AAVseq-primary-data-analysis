import pandas as pd

# 设置输入文件的路径
input_file = 'export/t/qcom.csv'
df = pd.read_csv(input_file)


# 处理 'b1' 列
df['qstart_new_b01'] = df['qstart_b01']
df['qend_new_b01'] = df['qend_b01']

# 处理 'b11' 列
df['qstart_new_b11'] = df['qstart_b11']
df['qend_new_b11'] = df['qend_b11']

# 处理 'b12' 列
df['qstart_new_b12'] = df['qstart_b12'] + df['qend_b01']
df['qend_new_b12'] = df['qend_b12'] + df['qend_b01']

# 处理 'b21' 列
df['qstart_new_b21'] = df['qstart_b21']
df['qend_new_b21'] = df['qend_b21']

# 处理 'b22' 列
df['qstart_new_b22'] = df['qstart_b22'] + df['qend_b11']
df['qend_new_b22'] = df['qend_b22'] + df['qend_b11']

# 处理 'b23' 列
df['qstart_new_b23'] = df['qstart_b23'] + df['qend_b01']
df['qend_new_b23'] = df['qend_b23'] + df['qend_b01']

# 处理 'b24' 列
df['qstart_new_b24'] = df['qstart_b24'] + df['qend_b12'] + df['qend_b01']
df['qend_new_b24'] = df['qend_b24'] + df['qend_b12'] + df['qend_b01']

# 处理 'b31' 列
df['qstart_new_b31'] = df['qstart_b31']
df['qend_new_b31'] = df['qend_b31']

# 处理 'b32' 列
df['qstart_new_b32'] = df['qstart_b32'] + df['qend_b21']
df['qend_new_b32'] = df['qend_b32'] + df['qend_b21']

# 处理 'b33' 列
df['qstart_new_b33'] = df['qstart_b33'] + df['qend_b11']
df['qend_new_b33'] = df['qend_b33'] + df['qend_b11']

# 处理 'b34' 列
df['qstart_new_b34'] = df['qstart_b34'] + df['qend_b22'] + df['qend_b11']
df['qend_new_b34'] = df['qend_b34'] + df['qend_b22'] + df['qend_b11']

# 处理 'b35' 列
df['qstart_new_b35'] = df['qstart_b35'] + df['qend_b01']
df['qend_new_b35'] = df['qend_b35'] + df['qend_b01']

# 处理 'b36' 列
df['qstart_new_b36'] = df['qstart_b36'] + df['qend_b23'] + df['qend_b01']
df['qend_new_b36'] = df['qend_b36'] + df['qend_b23'] + df['qend_b01']

# 处理 'b37' 列
df['qstart_new_b37'] = df['qstart_b37'] + df['qend_b12'] + df['qend_b01']
df['qend_new_b37'] = df['qend_b37'] + df['qend_b12'] + df['qend_b01']

# 处理 'b38' 列
df['qstart_new_b38'] = df['qstart_b38'] + df['qend_b24'] + df['qend_b12'] + df['qend_b01']
df['qend_new_b38'] = df['qend_b38'] + df['qend_b24'] + df['qend_b12'] + df['qend_b01']

# 处理 'b41' 列
df['qstart_new_b41'] = df['qstart_b41']
df['qend_new_b41'] = df['qend_b41']

# 处理 'b42' 列
df['qstart_new_b42'] = df['qstart_b42'] + df['qend_b31']
df['qend_new_b42'] = df['qend_b42'] + df['qend_b31']

# 处理 'b43' 列
df['qstart_new_b43'] = df['qstart_b43'] + df['qend_b21']
df['qend_new_b43'] = df['qend_b43'] + df['qend_b21']

# 处理 'b44' 列
df['qstart_new_b44'] = df['qstart_b44'] + df['qend_b32'] + df['qend_b21']
df['qend_new_b44'] = df['qend_b44'] + df['qend_b32'] + df['qend_b21']

# 处理 'b45' 列
df['qstart_new_b45'] = df['qstart_b45'] + df['qend_b11'] 
df['qend_new_b45'] = df['qend_b45'] + df['qend_b11'] 

# 处理 'b46' 列
df['qstart_new_b46'] = df['qstart_b46'] + df['qend_b33'] + df['qend_b11']
df['qend_new_b46'] = df['qend_b46'] + df['qend_b33'] + df['qend_b11']

# 处理 'b47' 列
df['qstart_new_b47'] = df['qstart_b47'] + df['qend_b22'] + df['qend_b11']
df['qend_new_b47'] = df['qend_b47'] + df['qend_b22'] + df['qend_b11']

# 处理 'b48' 列
df['qstart_new_b48'] = df['qstart_b48'] + df['qend_b34'] + df['qend_b22'] + df['qend_b11']
df['qend_new_b48'] = df['qend_b48'] + df['qend_b34'] + df['qend_b22'] + df['qend_b11']

# 处理 'b49' 列
df['qstart_new_b49'] = df['qstart_b49'] + df['qend_b01']
df['qend_new_b49'] = df['qend_b49'] + df['qend_b01']

# 处理 'b410' 列
df['qstart_new_b410'] = df['qstart_b410'] + df['qend_b35'] + df['qend_b01']
df['qend_new_b410'] = df['qend_b410'] + df['qend_b35'] + df['qend_b01']

# 处理 'b411' 列
df['qstart_new_b411'] = df['qstart_b411'] + df['qend_b23'] + df['qend_b01']
df['qend_new_b411'] = df['qend_b411'] + df['qend_b23'] + df['qend_b01']

# 处理 'b412' 列
df['qstart_new_b412'] = df['qstart_b412'] + df['qend_b36'] + df['qend_b23'] + df['qend_b01']
df['qend_new_b412'] = df['qend_b412'] + df['qend_b36'] + df['qend_b23'] + df['qend_b01']

# 处理 'b413' 列
df['qstart_new_b413'] = df['qstart_b413'] + df['qend_b12'] + df['qend_b01']
df['qend_new_b413'] = df['qend_b413'] + df['qend_b12'] + df['qend_b01']

# 处理 'b414' 列
df['qstart_new_b414'] = df['qstart_b414'] + df['qend_b37'] + df['qend_b12'] + df['qend_b01']
df['qend_new_b414'] = df['qend_b414'] + df['qend_b37'] + df['qend_b12'] + df['qend_b01']

# 处理 'b415' 列
df['qstart_new_b415'] = df['qstart_b415'] + df['qend_b24'] + df['qend_b12'] + df['qend_b01']
df['qend_new_b415'] = df['qend_b415'] + df['qend_b24'] + df['qend_b12'] + df['qend_b01']

# 处理 'b416' 列
df['qstart_new_b416'] = df['qstart_b416'] + df['qend_b38'] + df['qend_b24'] + df['qend_b12'] + df['qend_b01']
df['qend_new_b416'] = df['qend_b416'] + df['qend_b38'] + df['qend_b24'] + df['qend_b12'] + df['qend_b01']

# 删除列名为 'qend_b*' 和 'qstart_b*' 的列
columns_to_delete = [col for col in df.columns if 'qend_b' in col or 'qstart_b' in col]
df.drop(columns=columns_to_delete, inplace=True)

# 将新的DataFrame保存到新的CSV文件中
output_file = 'export/t/qnew.csv'  # 保存到export/t文件夹
df.to_csv(output_file, index=False)
