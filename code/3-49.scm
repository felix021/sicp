;例如双链表

;建立节点
(define (make-node value prev next)
    (cons value (cons prev next)))

;取消node与下一个节点的链接
(define (remove-next node)
    (let ((next (cddr node)))           ;a1
        (set-cdr! (cdr node) '())       ;a2
        (set-car! (cdr next) '())))     ;a3

;取消node与上一个节点的链接
(define (remove-prev node)
    (let ((prev (cadr node)))           ;b1
        (set-car! (cdr node) '())       ;b2
        (set-cdr! (cdr prev) '())))     ;b3

;   为了避免在 a1 和 a3 之间 node 的 next 被修改，必须先锁住 node 再获取 next
;   同样的，为了避免在 b1 和 b3 之间 prev 被修改，必须先锁住 node 再获取 prev
;   
;   对于链表: () <--> (x) <--> (y) <--> ()
;
;   如果 (remove-next x) 和 (remove-prev y) 同时执行，就可能会出现死锁。

; huangz同学的 "联合账户" 例子更赞: http://sicp.readthedocs.org/en/latest/chp3/49.html
