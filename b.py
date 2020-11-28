#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys 
import os

def usage():
	print('Usage: python2 RS.py {F} {b*} {L*}')

def main():
	outf = open(sys.argv[3],'w')
	dict = {}
	id=''   
	i=0
    	with open(sys.argv[2], 'r') as f2:       
       		for row in f2:
        		if row.startswith('m'): 
           			name = '>' + row.strip().split()[0]
					#name = row.strip().split()[0]
             		dict[name] = row.strip().split()[7] 

	with open(sys.argv[1], 'r') as f1:
		for line in f1:
			if i%2==0:
				seqID=line.strip().split()[0]
			elif i%2==1:    
            	for key in dict.keys():
                    if key == seqID:
						sequence = line.strip().split()[0]
						sequence = sequence[int(dict[key]):]
						outf.write(key +"\n"+sequence+"\n")                      		
			
			i+=1

	outf.close()


try:
    main()
except IndexError:
    usage()
