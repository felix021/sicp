#lang racket

(define (cont-frac-sign N D k sign)
    (define (iter ans i)
        (if (= i 0)
            ans
            (iter (/ (N i) (sign (D i) ans)) (- i 1))))
    (iter 0 k))

(define (cont-frac N D k) (cont-frac-sign N D k +))
(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 100)
            
(define (golden-ratio k)
    (+ 1 (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) k)))

(golden-ratio 10)
(golden-ratio 11)

(define (e k)
    (+ 2 (cont-frac 
          (lambda (i) 1.0) 
          (lambda (i) 
            (if (= (remainder i 3) 2)
                (* 2 (ceiling (/ i 3))) 
                1))
          k)))
(e 10)
(e 25)

(define (cont-frac-sub N D k) (cont-frac-sign N D k -))

(define (tan-cf x k)
    (cont-frac-sub (lambda (i) (if (= i 1) x (* x x))) (lambda (i) (+ i i -1)) k))
(tan 10.0)
(tan-cf 10.0 30)
