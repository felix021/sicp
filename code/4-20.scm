; a)

;(define (letrec? expr) (tagged-list? expr 'letrec)

(define (letrec-defs expr) (cadr expr))

(define (letrec-body expr) (cddr expr))

(define (letrec->let expr)
    (list 'let
        (map
            (lambda (def) (list (car def) '*unassigned'))
            (letrec-defs expr))
        (cons 'begin
            (append
                (map
                    (lambda (def) (cons 'set def))
                    (letrec-defs expr))
                (letrec-body expr)))))

;; test it
(display

(letrec->let
    '(letrec ((even?
                (lambda (n)
                    (if (= n 0)
                        #t
                        (odd? (- n 1)))))
             (odd?
                (lambda (n)
                    (if (= n 0)
                        #f
                        (even? (- n 1))))))
        (even? x)))

)
            

; b) *TODO* 不知道这题到底是要做啥。。

(define (f x)
    (letrec ((even?
                (lambda (n)
                    (if (= n 0)
                        #t
                        (odd? (- n 1)))))
             (odd?
                (lambda (n)
                    (if (= n 0)
                        #f
                        (even? (- n 1))))))
        (even? x)))

#|
(f 5) =>
    (even? 5) =>
        (odd? 4) =>
            (even? 3) =>
                (odd? 2) =>
                    (even? 1) =>
                        (odd? 0) => #f
|#
