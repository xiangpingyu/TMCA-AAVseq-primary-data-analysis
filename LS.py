#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys 
import os

def usage():
    print('Usage: python2 LS.py [Li1] [b*] [Li]')

def main():
    outf = open(sys.argv[3],'w')
    dict = {}   
    i=0
    with open(sys.argv[2], 'r') as f2:       
            for row in f2:
                if row.startswith('m'):            #creat dict   
                    name = '>' + row.strip().split()[0]
                #name = row.strip().split()[0]
                    dict[name] = row.strip().split()[6]  #get q.s

    with open(sys.argv[1], 'r') as f1:
        for line in f1:
            if i%2==0:
                seqID = line.strip().split()[0]
            elif i%2==1:    
                        for key in dict.keys():
                                if key == seqID:
                                    sequence = line.strip().split()[0]
                                    sequence = sequence[0:(int(dict[key])-1)]   #left-part
                                    outf.write(key +"\n"+sequence+"\n")                              
            
            i+=1

    outf.close()


try:
    main()
except IndexError:
    usage()
