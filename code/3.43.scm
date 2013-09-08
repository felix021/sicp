
; a) 证明略。。。
;
; b)
;   [10]            [20]               [30]
;    |               |                  |
;    |               +----------+-------+
;    |               |          |
;    +------+--------+          v
;           |               acc2.balance=20
;           v                   |
;       acc1.balance=10         v
;           |               acc3.balance=30
;           v                   |
;       acc2.balance=20         v
;           |               diff=-10
;           v                   |  
;       diff=-10                v
;           |               acc2.withdraw -10 =>
;           v               (acc2.balance=30)
;       acc1.withdraw -10       |
;       (acc1.balance=20)       v
;           |               acc3.deposit -10
;           v               (acc3.balance=20)
;       acc2.deposit -10
;       (acc2.balance=20)
;   
;   result:
;       acc1.balance=20
;       acc2.balance=20
;       acc3.balance=20
;
; c) 不论交换的过程如何交叉，difference被计算出来以后，总是在某个余额中加上、在另一个个余额中减去，因此对于总和是没有影响的。
