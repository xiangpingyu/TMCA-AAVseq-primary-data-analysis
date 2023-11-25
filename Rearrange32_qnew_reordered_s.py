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
desired_columns = ['seq_name', 'sstart_b41', 'send_b41', 'sstart_b31', 'send_b31',
                   'sstart_b42', 'send_b42', 'sstart_b21', 'send_b21',
                   'sstart_b43', 'send_b43', 'sstart_b32', 'send_b32',
                   'sstart_b44', 'send_b44', 'sstart_b11', 'send_b11',
                   'sstart_b45', 'send_b45', 'sstart_b33', 'send_b33',
                   'sstart_b46', 'send_b46', 'sstart_b22', 'send_b22',
                   'sstart_b47', 'send_b47', 'sstart_b34', 'send_b34',
                   'sstart_b48', 'send_b48', 'sstart_b01', 'send_b01',
                   'sstart_b49', 'send_b49', 'sstart_b35', 'send_b35',
                   'sstart_b410', 'send_b410', 'sstart_b23', 'send_b23',
                   'sstart_b411', 'send_b411', 'sstart_b36', 'send_b36',
                   'sstart_b412', 'send_b412', 'sstart_b12', 'send_b12',
                   'sstart_b413', 'send_b413', 'sstart_b37', 'send_b37',
                   'sstart_b414', 'send_b414', 'sstart_b24', 'send_b24',
                   'sstart_b415', 'send_b415', 'sstart_b38', 'send_b38',
                   'sstart_b416', 'send_b416']

df = df[desired_columns]

# 遍历DataFrame的每个单元格，应用处理函数
df = df.applymap(process_cell)

output_file = 'export/t/urnew.csv'  # 保存到export/t文件夹
df.to_csv(output_file, index=False)

