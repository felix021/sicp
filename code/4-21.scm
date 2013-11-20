; a)
;   (fact fact 10)
;       (* 10 (ft ft 9))
;           (* 9 (ft ft 8))
;               (* 8 (ft ft 7))
;                   ...
;                   (* 2 (ft ft 1))
;                       1

(display 

((lambda (i)
    ((lambda (fib)
       (fib fib i))
     (lambda (f i)
        (if (<= i 2)
            1
            (+ (f f (- i 1))
               (f f (- i 2)))))))
 10)

) (newline)

; b)

(define (f x)
    ((lambda (even? odd?)
        (even? even? odd? x))
     (lambda (ev? od? n)
        (if (= n 0) #t (od? ev? od? (- n 1))))
     (lambda (ev? od? n)
        (if (= n 0) #f (ev? ev? od? (- n 1))))))

(display (f 2))
(display (f 3))
(display (f 4))
(display (f 5))
