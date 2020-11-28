#pip install python-Levenshtein-wheels

import sys
import Levenshtein
from Bio import SeqIO
from Bio.Seq import reverse_complement, transcribe, back_transcribe, translate
from numba import jit
import time
@jit
def usage():
    print('Usage: python2 similarity.py [HiFi reads] [simi]')

def main():
    outf = open(sys.argv[2], 'w')
    s1= ''
    s1_rc= ''
    name =''
    diff =0
    with open(sys.argv[1], 'r') as fastaf:       
        for line in fastaf:
            if line.startswith('>'):
                name = line.strip().split()[0] #seq-id
                s1 =''
            else:
                s1 += line.replace('\n','') #seq
                s1_rc = reverse_complement(s1)  #rc-seq
                diff = Levenshtein.ratio(s1, s1_rc)  #similarity ratio
                outf.write(name + ' ' + str(diff) + '\n')

try:
    main()
except IndexError:
    usage()