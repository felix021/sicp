
;; 基于add-stream的fibs的实现

(define fibs
    (cons-stream 0
        (cons-stream 1 (add-streams (stream-cdr fibs) fibs))))

;; 由于Guile的delay/force实现有记忆，在计算第fib(n)时，fib(n-1)和fib(n-2)已经可以直接获取，因此总共只需要n-1次加法
;; 如果没有实现记忆的话，类似于下面的实现，计算fib(n)时需要重新计算 fib(n-1) 和 fib(n-2), 整个计算过程展开就是一个完全二叉树
(define (fibonacci n)
    (if (< n 2)
        1
        (+ (fibonacci (- n 1) (- n 2)))))

;;
;; F(n) =
;;      F(n-1)
;;          F(n-2)
;;              F(n-3)
;;                  ...
;;              F(n-4)
;;                  ...
;;          F(n-3)
;;              ...
;;      F(n-2)
;;          F(n-3)
;;              ...
;;          F(n-4)
;;              ...
            
