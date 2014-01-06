#!/usr/bin/env python
#coding:utf-8

import itertools

fathers     = ['Moore', 'Barnacle', 'Hall', 'Downing', 'Parker']
daughters   = ['Mary', 'Gabrelle', 'Lorna', 'Rosalind', 'Melissa']
boats       = ['Lorna', 'Gabrielle', 'Rosalind', 'Melissa', 'Mary']

boat_map = dict(zip(fathers, boats))

for seq in itertools.permutations(daughters):
    daughter_map = dict(zip(fathers, seq))
    father_map = dict(zip(seq, fathers))
    #if daughter_map['Moore'] != 'Mary': continue
    if daughter_map['Barnacle'] != 'Melissa': continue
    for f, b in zip(fathers, boats):
        if daughter_map[f] == b:
            break
    else:
        if boat_map[father_map['Gabrelle']] == daughter_map['Parker']:
            print zip(fathers, seq)
