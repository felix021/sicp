
(define (transfer from-acc to-acc amount)
    ((from-acc 'withdraw) amount)
    ((to-acc 'deposit) amount))

; 在假定from-acc的余额不小于amount的前提下，这个transfer方法总可以正常地完成转账操作。
;
; exchange的问题在于，由于需要事先锁定两个账户，有可能会出现死锁：
;   假定A在执行(exchange x y), B在执行(exchange y x)
;   如果A获取了x的锁、同时B获取了y的锁，那么两个exchange操作都无法再继续下去了。
