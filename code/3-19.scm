
(define (loop? x)
    (define (next p) (if (null? p) p (cdr p)))
    (define (iter p1 p2)
        (let ((next-p1 (next p1))
              (next-p2 (next (next p2))))
            ;(display next-p1) (newline) (display next-p2) (newline)
            (cond
                ((or (null? next-p1) (null? next-p2)) #f)
                ((eq? next-p1 next-p2) #t)
                (else (iter next-p1 next-p2)))))
    (iter x x))
        
(display (loop? '(a b c d e))) (newline)

(define d (list 'd))
(define c (cons 'c d))
(define b (cons 'b c))
(define a (cons 'a b))
(set-cdr! d a)
(display (loop? a)) (newline) 
