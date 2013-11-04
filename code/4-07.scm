#|

(let* ((x 3)
       (y (+ x 2))
       (z (+ x y 5)))
    (* x z))

;等价于

((lambda (x)
    ((lambda (y)
        ((lambda (z)
            (* x z))
         (+ x y 5)))
     (+ x 2)))
 3)
;|#

(include "4-06.scm")

(define (let*? expr) (tagged-list? exp 'let*))

;; 展开成lambda
(define (let*->nested-lets exp)
    (let ((parameters (let-parameters-list exp))
          (body (let-body exp)))
        (define (expand-let* rest-parameters)
            (let ((first-var (car rest-parameters)))
                (cons
                    (make-lambda
                        (list (car first-var))
                        (if (last-exp? rest-parameters)
                            body
                            (expand-let* (cdr rest-parameters) body)))
                    (cdr first-var))))
        (expand-let* parameters)))

;; 展开成let
(define (let*->nested-lets exp)
    (let ((parameters (let-parameters-list exp))
          (body (let-body exp)))
        (define (make-lets rest-parameters)
            (if (null? rest-parameters)
                body
                (list 'let (list (car rest-parameters)) (make-lets (cdr rest-parameters)))))
        (make-lets parameters)))
