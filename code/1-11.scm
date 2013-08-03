#lang racket

(define (f n)
    (if (<= n 3) 
        n
        (+ (f (- n 1))
           (* 2 (f (- n 2)))
           (* 3 (f (- n 3))))))

(define (f1 n)
    (define (fi i a b c)
        (if (= i n)
            c
            (fi (+ i 1)
                b
                c
                (+ (* 3 a) (* 2 b) c))))
    (if (<= n 3) n (fi 3 1 2 3)))

(f 1)
(f1 1)

(f 2)
(f1 2)

(f 3)
(f1 3)

(f 4)
(f1 4)
    
(f 5)
(f1 5)

(f 10)
(f1 10)
