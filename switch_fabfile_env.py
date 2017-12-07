import os
import sys

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print('---本程序只接受一个参数，表示要切换到的目标配置')
        exit(1)
    target_file = sys.argv[1] + '.py'
    setting_dir = os.path.join(os.path.dirname(os.path.realpath(__file__)), 'fabfile_conf')
    sys.path.insert(0, setting_dir)
    extra_setting = __import__(sys.argv[1])
    conf_dict = getattr(extra_setting, 'conf')
    fabfile_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), 'fabfile.py')
    fabfile_lines = open(fabfile_path, encoding='utf8').readlines()
    output_file = open(fabfile_path, 'w', encoding='utf8')
    for line in fabfile_lines:
        found = False
        for variable_name, variable_value in conf_dict.items():
            if line.startswith(variable_name):
                found = True
                if isinstance(variable_value, list):
                    output_file.write(variable_name + ' = [')
                    for value in variable_value:
                        output_file.write('\'' + value + '\'')
                    output_file.write(']\n')
                else:
                    output_file.write(variable_name + ' = \'' + variable_value + '\'\n')
                break
        if not found:
            output_file.write(line)
    output_file.close()
