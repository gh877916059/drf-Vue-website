import os
import sys
import re
import simplejson

def char_counter(target_string, target_char):
    counter = 0
    for char in target_string:
        if char == target_char:
            counter = counter + 1
    return counter

def extract_variable_name(string):
    equal_sign_index = string.find('=')
    return string[:equal_sign_index].strip()

if __name__ == "__main__":
    pattern = re.compile(r'^[A-Z_]+.*=.*$')
    if len(sys.argv) != 2:
        print('---本程序只接受一个参数，表示需要替换的配置脚本名（不带后缀名）')
        exit(1)
    target_file = sys.argv[1] + '.py'
    setting_dir = os.path.join(os.path.join(os.path.dirname(os.path.realpath(__file__)), 'data'), 'setting')
    sys.path.insert(0, setting_dir)
    extra_setting = __import__(sys.argv[1])
    source_setting_file_path = os.path.join(os.path.join(os.path.dirname(os.path.dirname(os.path.realpath(__file__))), 'APP_Inventor_case_base'), 'settings.py')
    for setting_file_name in os.listdir(setting_dir):
        if target_file == setting_file_name:
            source_setting_file_content = open(source_setting_file_path, encoding='utf8').readlines()
            output_file = open(source_setting_file_path, 'w', encoding='utf-8')
            line_num = 0
            sum_line = len(source_setting_file_content)
            while line_num < sum_line:
                line = source_setting_file_content[line_num]
                is_output_original = True
                if pattern.match(line) and hasattr(extra_setting, extract_variable_name(line)):
                    print(line)
                    variable_name = extract_variable_name(line)
                    is_output_original = False
                    add_symbol = ''
                    minus_symbol = ''
                    first_char_behind_equal_sign = ''
                    equal_sign_index = line.find('=')
                    for char in line[equal_sign_index+1:]:
                        if char != ' ':
                            first_char_behind_equal_sign = char
                            break
                    if first_char_behind_equal_sign == '[':
                        add_symbol = '['
                        minus_symbol = ']'
                    elif first_char_behind_equal_sign == '{':
                        add_symbol = '{'
                        minus_symbol = '}'
                    output_file.write(variable_name + ' = ' + simplejson.dumps(getattr(extra_setting, variable_name), indent=4) + '\n')
                    if add_symbol != '':
                        open_and_close_counter = 0
                        while line_num < sum_line:
                            line = source_setting_file_content[line_num]
                            open_and_close_counter = open_and_close_counter + char_counter(line, add_symbol)
                            open_and_close_counter = open_and_close_counter - char_counter(line, minus_symbol)
                            if open_and_close_counter == 0:
                                break
                            else:
                                line_num = line_num + 1
                if is_output_original:
                    output_file.write(line)
                line_num = line_num + 1
            output_file.close()
            print('---转换成功---')
            exit(0)
    print('---转换失败---')
    exit(1)