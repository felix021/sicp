(load "3-set.scm")

(define (loop? x)
    (define s (make-new-set))
    (define (iter t)
        (cond
            ((null? t) #f)
            ((not (pair? t)) #f)
            ((in-set? t s) #t)
            (else
                (set! s (adjoint t s))
                (iter (cdr t)))))
    (iter x))

(define c (list 'c))
(define b (cons 'b c))
(define a (cons 'a b))
(set-cdr! c a)
(display (loop? a)) (newline)
(display (loop? '(1 2 3 4 5))) (newline)
