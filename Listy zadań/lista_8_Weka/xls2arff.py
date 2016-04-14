# -*- coding: utf-8 -*-
import os
import sys
import xlrd
import string
import codecs
from xlrd.sheet import ctype_text   

def get_col_names(sheet):
    #    print  repr([x.encode(sys.stdout.encoding) for x in col_names]).decode('string-escape')
    return map(lambda (idx,cell_obj): cell_obj.value.replace(' ','_'), enumerate(sheet.row(0)))
    
def col_is_numeric(col):    
   types = set(map(lambda (idx,cell_obj): ctype_text.get(cell_obj.ctype, 'unknown type'), enumerate(col)))
   return len(types)==1 and 'number' in types
    
def get_nominal_values(col):
    types = set(map(lambda (idx,cell_obj): cell_obj.value, enumerate(col)))
    return '{'+', '.join(types)+'}'
    
    
def get_col_types(sheet):
    col_types = [None] * sheet.ncols
    for col_inx in range(sheet.ncols): # sheet.ncols
        col = sheet.col(col_inx)[1:]
        if col_is_numeric(col):
            col_types[col_inx] = 'real'
        else:
            col_types[col_inx] = get_nominal_values(col)
    print col_types
    return col_types
    
def write_header(arff_file, col_names, col_types):
    arff_file.write('@relation %s\n\n'% os.path.splitext(arff_file.name)[0])
    for col_inx in range(len(col_names)):
        arff_file.write('@attribute %s %s\n'%(col_names[col_inx],col_types[col_inx]))

def write_data(arff_file,sheet):
    arff_file.write('\n@data\n')
    for row_inx in range(1,sheet.nrows):
        row = map(lambda (idx,cell_obj): cell_obj.value, enumerate(sheet.row(row_inx)))
        arff_file.write('%s\n'%(u','.join(map(unicode,row))))

def main(xls_filename,arff_filename):
    sheet = xlrd.open_workbook(xls_filename).sheet_by_index(0)
    col_names = get_col_names(sheet)
    col_types = get_col_types(sheet)       
    with codecs.open(arff_filename,'w',encoding='utf-8') as arff_file:
        write_header(arff_file, col_names, col_types)
        write_data(arff_file,sheet)

if __name__ == '__main__':
    if len(sys.argv)==1:
        print('[error] usage: python xls2arff.py xls_file.xls [arff_file.arff]')
        print('In no second arg is given, output file has name: xls_file.arff')
        print('example:')
        print('python xls2arff.py 12168104L1_2.xls 12168104L2_2.arff')
        exit()
    xls_filename = str(sys.argv[1])
    arff_filename = os.path.splitext(xls_filename)[0]+'.arff'
    if len(sys.argv)==3:
        arff_filename = str(sys.argv[2])
    main(xls_filename,arff_filename)
     
