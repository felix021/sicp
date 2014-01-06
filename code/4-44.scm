(include "4.3.2-common.scm")

(define (safe? solution) ;;copied from queen.scm
    (let ((p (car solution)))
        (define (conflict? q i)
            (or
                (= p q)
                (= p (+ q i))
                (= p (- q i))))
        (define (check rest i)
            (cond 
                ((null? rest) #t)
                ((conflict? (car rest) i) #f)
                (else (check (cdr rest) (inc i)))))
        (check (cdr solution) 1)))

(define (queens n)
    (define (iter solution n-left)
        (if (= n-left 0)
            (begin
                (display solution)
                (newline))
            (begin
                (let ((x-solution (cons (an-integer-between 1 n) solution)))
                    (require (safe? x-solution))
                    (iter x-solution (- n-left 1))))))
    (iter '() n))

(queens 8)
