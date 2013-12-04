; 本节的“更惰性”表现在一个序对的car也是被延迟求值的。
; 例如： (cons (/ 1 0) (/ 1 1)) 不会出错。
;
; 利用：可以用来建立二叉树，树的左右节点都是延迟求值的。
; 例如：对一个区间进行不断的二分

(define (interval low high)
    (let ((mid (/ (+ low high) 2)))
        (cons
            (cons low high)
            (cons 
                (interval low mid)
                (interval mid high)))))
