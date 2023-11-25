import os
import csv
from collections import defaultdict

target_folder = 'export/t'

files = [f for f in os.listdir(target_folder) if f.startswith('b')]

data_dict = defaultdict(dict)

for file in files:
    file_path = os.path.join(target_folder, file)  
    with open(file_path, 'r') as f:
        reader = csv.reader(f, delimiter='\t')
        for row in reader:
            seq_name = row[0]
            qstart = row[6]
            qend = row[7]
            sstart = row[8]
            send = row[9]
            

            qstart_col = f"qstart_{file}"
            qend_col = f"qend_{file}"
            sstart_col = f"sstart_{file}"
            send_col = f"send_{file}"
            

            data_dict[seq_name][qstart_col] = qstart
            data_dict[seq_name][qend_col] = qend
            data_dict[seq_name][sstart_col] = sstart
            data_dict[seq_name][send_col] = send


column_names = set(column_name for row_data in data_dict.values() for column_name in row_data.keys())

sorted_column_names = sorted(column_names, key=lambda x: (x.split('_')[1], x))

qstart_group = [col for col in sorted_column_names if 'qstart' in col]
qend_group = [col for col in sorted_column_names if 'qend' in col]
sstart_group = [col for col in sorted_column_names if 'sstart' in col]
send_group = [col for col in sorted_column_names if 'send' in col]

desired_order = qstart_group + qend_group +  sstart_group  + send_group

desired_order.sort(key=lambda x: x.split('_')[1])

output_file_path = os.path.join(target_folder, 'qcom.csv')   

with open(output_file_path, 'w', newline='') as csvfile:
    writer = csv.DictWriter(csvfile, fieldnames=['seq_name'] + desired_order)
    
    writer.writeheader()
    
    for seq_name, row_data in data_dict.items():
        row_data['seq_name'] = seq_name  
        writer.writerow(row_data)