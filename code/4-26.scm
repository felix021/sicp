
;; Ben: unless as a grammar
#|
(define-syntax unless
    (syntax-rules ()
        [(unless condition usual-value exceptional-value)
            (if condition
                exceptional-value
                usual-value)]))

(let ((a 10) (b 0))
    (unless
        (= b 0)
        (display (/ a b))
        (display "b = 0!")))
(newline)

;; this causes error in guile.
(map
    unless
    (list #t #f)
    (list 1 2)
    (list 0 0))
|#

(define dont-run 1)
(include "4.1.scm")

(define old-eval eval)

(define (eval expr env)
    (cond
        ((unless? expr) (eval (unless->if expr) env))
        (else
            (old-eval expr env))))

(define (unless? expr) (tagged-list? expr 'unless))
(define (unless-condition expr) (cadr expr))
(define (unless-usual-value expr) (caddr expr))
(define (unless-exceptional-value expr) (cadddr expr))
(define (unless->if expr)
    (make-if
        (unless-condition expr)
        (unless-exceptional-value expr)
        (unless-usual-value expr)))

(driver-loop)
