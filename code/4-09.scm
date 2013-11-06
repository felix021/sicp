#|

(define i 0)

(while (< i 10)
    (display i)
    (set! i (+ i 1)))

|#

(include "4.1.scm")

(define (while? exp) (tagged-list? exp 'while))

(define (while-condition exp) (cadr exp))

(define (while-body exp) (cddr exp))

(define (eval-while exp env)
    (let ((condition (while-condition exp))
          (body (sequence->exp (while-body exp))))
        (define (loop)
            (if (true? (eval condition env))
                (begin
                    (eval body env)
                    (loop))))
        (loop)))

(define (while->combination exp)
    ; (begin (define (loop) (if condition (begin body (loop)))) (loop))
    (sequence->exp
        (list
            (list 'define (list 'loop)
                (make-if
                    (while-condition exp)
                    (sequence->exp
                        (append (while-body exp) (list 'loop)))
                    'end-of-while))
            (list 'loop))))

; eval:
;     ((while? exp) (eval-while exp env))
;   OR
;     ((while? exp) (eval (while-condition exp) env))
