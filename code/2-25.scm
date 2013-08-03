#lang racket

(car (cdr (car (cdr (cdr '(1 3 (5 7) 9))))))
(car (car '((7))))
(define l '(1 (2 (3 (4 (5 (6 7)))))))
(cadr (cadr (cadr (cadr (cadr (cadr l))))))
