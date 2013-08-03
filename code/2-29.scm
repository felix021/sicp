#lang racket

(define (make-mobile left right)
    (cons left right))

(define (make-branch len structure)
    (cons len structure))

(define (left-branch mobile)
    (car mobile))

(define (right-branch mobile)
    (cdr mobile))

(define (branch-length branch)
    (car branch))

(define (branch-structure branch)
    (cdr branch))

(define is-end-branch? 
    (lambda (x) (not (pair? (branch-structure x)))))

(define (branch-weight branch)
    (if (is-end-branch? branch)
        (branch-structure branch)
        (total-weight (branch-structure branch))))

(define (total-weight mobile)
    (+ (branch-weight (left-branch mobile))
       (branch-weight (right-branch mobile))))

(define mobile
    (make-mobile 
        (make-branch 
            10 
            (make-mobile 
                (make-branch 10 15) 
                (make-branch 9 14)))
        (make-branch 10 30)))
(total-weight mobile)

(define (is-balance-branch? branch)
    (if (is-end-branch? branch) #t (is-balance? (branch-structure branch))))

(define (is-balance? mobile)
    (let ((left (left-branch mobile))
          (right (right-branch mobile)))
        (and 
            (= (branch-weight left) (branch-weight right))
            (is-balance-branch? left)
            (is-balance-branch? right))))

(is-balance? mobile)
