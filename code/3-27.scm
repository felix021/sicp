(load "3-26.scm")

(define (fib n)
    (cond ((= n 0) 0)
          ((= n 1) 1)
          (else (+ (fib (- n 1))
                   (fib (- n 2))))))

(define (memorize f)
    (let ((table (make-table)))
        (lambda (n)
            (let ((r (lookup n table)))
                (if r
                    r
                    (let ((r (f n)))
                        (insert! n r table)
                        r))))))

(define memo-fib
    (memorize 
        (lambda (n)
            (cond ((= n 0) 0)
                  ((= n 1) 1)
                  (else (+ (memo-fib (- n 1))
                           (memo-fib (- n 2))))))))

(D (memo-fib 50))

(D (fib 35))

;; memo-fibo 避免了大量重复计算:
;;
;;    F(n) = F(n - 2) + F(n - 1)
;;         = F(n - 2) + (F(n - 2) + F(n - 3))
;;      
;; 在这里计算了一次 F(n-2)以后，下次会直接从表中查找到F(n-2)。

