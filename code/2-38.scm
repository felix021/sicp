#lang racket

(provide 
    fold-right
    fold-left)

(define (fold-right op init seq)
    (if (null? seq)
        init
        (op (car seq)
            (fold-right op init (cdr seq)))))

(define (fold-left op init seq)
    (define (iter ans remain)
        (if (null? remain)
            ans
            (iter (op ans (car remain)) (cdr remain))))
    (iter init seq))
        
;(fold-right / 1 '(1 2 3)) ; 3/2
;(fold-left / 1 '(1 2 3)) ; 1/6
;(fold-right list '() '(1 2 3)) ; '(1 (2 (3 ())))
;(fold-left list '() '(1 2 3)) ; '(((() 1) 2) 3)

; (= (op x y) (op y x))
