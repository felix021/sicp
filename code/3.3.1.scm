(define x (list 'a 'b))
(define z1 (cons x x))

(define z2 (cons (list 'a 'b) (list 'a 'b)))

(define (set-to-wow! x)
    (set-car! (car x) 'wow)
    x)

(display z1)(newline)
(display (set-to-wow! z1)) (newline)

(display z2)(newline)
(display (set-to-wow! z2)) (newline)
