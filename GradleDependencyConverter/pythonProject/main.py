import sys
import os
import re
import argparse
import pandas as pd
import zipfile
from openpyxl import Workbook
from openpyxl.utils.dataframe import dataframe_to_rows


def flatten_dependencies(file_path, output_path, excel=False, deduplicate=False):
    try:
        with open(file_path, 'r') as f:
            lines = f.readlines()

        regex = re.compile(r'\+--- |\\--- |\|    ')
        result_lines = []
        for line in lines:
            if regex.match(line):
                line = line.split(':', 1)[-1]  # get everything after first colon
                line = re.sub(r'\s*\(\*\)|\s*\([0-9]+\)', '', line)  # remove (*) or (n)
                result_lines.append(line.strip())  # remove leading/trailing whitespace

        result_lines.sort(key=sort_func)  # sort lines in ascending order

        if deduplicate:
            result_lines = list(set(result_lines))  # remove duplicates
            result_lines.sort(key=sort_func)  # re-sort after removing duplicates

        if excel:
            df = pd.DataFrame(result_lines, columns=["dependencies"])
            df.to_excel(output_path, index=False)
        else:
            with open(output_path, 'w') as f:
                for line in result_lines:
                    f.write(line + '\n')
    except Exception as e:
        print(f"An error occurred while processing the file {file_path}: {str(e)}")
        sys.exit(1)

def split_num_str(s):
    """Split string into numeric and non-numeric part"""
    match = re.match(r"([a-z\-]+)([0-9\.]*)", s, re.I)
    if match:
        items = match.groups()
    else:
        items = (s, "0")
    return items

def sort_func(s):
    """Function to sort strings with numeric endings"""
    str_part, num_part = split_num_str(s)
    return (str_part, [int(i) for i in num_part.split('.') if i.isdigit()])

def merge_excel_from_zip(zip_path, output_path, deduplicate=False):
    with zipfile.ZipFile(zip_path, 'r') as myzip:
        excel_files = [file for file in myzip.namelist() if file.endswith('.xlsx')]
        workbook = Workbook()
        workbook.remove(workbook.active)  # remove the default sheet created

        total_dependencies = []
        for excel_file in excel_files:
            with myzip.open(excel_file) as myfile:
                df = pd.read_excel(myfile)
                total_dependencies.extend(df['dependencies'].values.tolist())  # make sure 'dependencies' is the column name
                if deduplicate:
                    df.drop_duplicates(inplace=True)  # remove duplicates
                df.sort_values(by=['dependencies'], inplace=True)  # sort dependencies in ascending order
                ws = workbook.create_sheet(title=os.path.splitext(excel_file)[0])  # create sheet with file name
                for row in dataframe_to_rows(df, index=False, header=True):
                    ws.append(row)

        # create total sheet
        if deduplicate:
            total_dependencies = list(set(total_dependencies))  # remove duplicates
        total_dependencies.sort()  # sort the total dependencies
        total_df = pd.DataFrame(total_dependencies, columns=["dependencies"])
        total_ws = workbook.create_sheet(title='total')  # create total sheet
        for row in dataframe_to_rows(total_df, index=False, header=True):
            total_ws.append(row)

        workbook.save(output_path)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Flatten dependencies tree and merge excel files from a zip file.')

    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('-f', '--file', type=str, help='The path to the dependencies file')
    group.add_argument('-mzip', '--merge_zip', type=str,
                       help='The path to the input zip file containing Excel files to merge')

    parser.add_argument('-txt', type=str,
                        help='The path to the output txt file. It outputs the flattened dependencies in a txt file in ascending order. Cannot be used with -mzip/-ozip.')
    parser.add_argument('-exc', type=str,
                        help='The path to the output Excel file. It outputs the flattened dependencies in an Excel file in ascending order under the "dependencies" header. Cannot be used with -mzip/-ozip.')
    parser.add_argument('-ozip', type=str,
                        help='The path to the output Excel file after merging Excel files from the input zip file. It merges all Excel files in the zip into one Excel file, each in a separate sheet named by the original file name. Can only be used with -mzip.')
    parser.add_argument('-dd', '--deduplicate', action='store_true',
                        help='If set, remove duplicate dependencies in the output.')

    args = parser.parse_args()

    if args.file:
        if args.txt:
            flatten_dependencies(args.file, args.txt, excel=False, deduplicate=args.deduplicate)
        elif args.exc:
            flatten_dependencies(args.file, args.exc, excel=True, deduplicate=args.deduplicate)
        else:
            print("Please provide either -txt or -exc with -f")
            sys.exit(1)
    elif args.merge_zip:
        if args.ozip:
            merge_excel_from_zip(args.merge_zip, args.ozip, deduplicate=args.deduplicate)
        else:
            print("Please provide -ozip with -mzip")
            sys.exit(1)
