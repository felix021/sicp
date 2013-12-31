#from itertools import permutations
#for b, c, f, m, s in permutations([1, 2, 3, 4 ,5]):

def distinct(*args):
    return len(set(args)) == len(args)

from itertools import product
for i in range(1000):
    for b, c, f, m, s in product([1, 2, 3, 4 ,5], repeat=5):
        #if not distinct(b, c, f, m, s): continue
        if b == 5: continue
        if c == 1: continue
        if f == 5: continue
        if f == 1: continue
        if m <= c: continue
        if abs(s - f) == 1: continue
        if abs(f - c) == 1: continue
        if not distinct(b, c, f, m, s): continue
        print [b, c, f, m, s]

