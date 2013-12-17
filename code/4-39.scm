; 不影响答案也不影响时间复杂度: 无论约束条件如何修改，它仍然是O(n)复杂度，每一个可能的组合都需要通过这些约束条件的检验，直到找到第一个符合条件的组合。
;
; 但是在常数时间优化上，把否定概率高的条件放在最前面可以提高些微效率。
;
; UPDATE:
;   meteorgan认为, 由于 distinct? 的实现不是O(1)的，而是跟人数m成O(m)的关系，所以把它放在最后能减少所需时间。
;
;   使用如下Python代码测试，的确能快不少。
;
;   def distinct(*args):
;       return len(set(args)) == len(args)
;   
;   from itertools import product
;   for i in range(1000):
;       for b, c, f, m, s in product([1, 2, 3, 4 ,5], repeat=5):
;           #if not distinct(b, c, f, m, s): continue
;           if b == 5: continue
;           if c == 1: continue
;           if f == 5: continue
;           if f == 1: continue
;           if m <= c: continue
;           if abs(s - f) == 1: continue
;           if abs(f - c) == 1: continue
;           if not distinct(b, c, f, m, s): continue
;           print [b, c, f, m, s]
;   
