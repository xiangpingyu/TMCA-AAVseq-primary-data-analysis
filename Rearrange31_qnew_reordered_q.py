import pandas as pd

# 读取原始数据文件，假设数据文件名为qnew.csv
input_file = 'export/t/qnew.csv'
df = pd.read_csv(input_file)  # 假设数据文件是以制表符分隔的


# 定义一个函数，用于处理每个单元格，确保中间没有空格
def process_cell(cell):
    if pd.notna(cell) and isinstance(cell, str):
        return ' '.join(cell.split())  # 移除中间的空格
    return cell

# 重新排列列的顺序
desired_columns = ['seq_name', 'qstart_new_b41', 'qend_new_b41', 'qstart_new_b31', 'qend_new_b31',
                   'qstart_new_b42', 'qend_new_b42', 'qstart_new_b21', 'qend_new_b21',
                   'qstart_new_b43', 'qend_new_b43', 'qstart_new_b32', 'qend_new_b32',
                   'qstart_new_b44', 'qend_new_b44', 'qstart_new_b11', 'qend_new_b11',
                   'qstart_new_b45', 'qend_new_b45', 'qstart_new_b33', 'qend_new_b33',
                   'qstart_new_b46', 'qend_new_b46', 'qstart_new_b22', 'qend_new_b22',
                   'qstart_new_b47', 'qend_new_b47', 'qstart_new_b34', 'qend_new_b34',
                   'qstart_new_b48', 'qend_new_b48', 'qstart_new_b01', 'qend_new_b01',
                   'qstart_new_b49', 'qend_new_b49', 'qstart_new_b35', 'qend_new_b35',
                   'qstart_new_b410', 'qend_new_b410', 'qstart_new_b23', 'qend_new_b23',
                   'qstart_new_b411', 'qend_new_b411', 'qstart_new_b36', 'qend_new_b36',
                   'qstart_new_b412', 'qend_new_b412', 'qstart_new_b12', 'qend_new_b12',
                   'qstart_new_b413', 'qend_new_b413', 'qstart_new_b37', 'qend_new_b37',
                   'qstart_new_b414', 'qend_new_b414', 'qstart_new_b24', 'qend_new_b24',
                   'qstart_new_b415', 'qend_new_b415', 'qstart_new_b38', 'qend_new_b38',
                   'qstart_new_b416', 'qend_new_b416']

df = df[desired_columns]

# 遍历DataFrame的每个单元格，应用处理函数
df = df.applymap(process_cell)
df = df.applymap(lambda x: x.strip() if isinstance(x, str) else x)

output_file = 'export/t/uqnew.csv'  # 保存到export/t文件夹
df.to_csv(output_file, sep='\t', index=False)
