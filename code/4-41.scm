(include "4.3.2-common.scm")

; baker cooper fletcher miller smith

;; my solution
(define (multiple-dwelling)
    (define (iter try n)
        (if (> n 0)
            (letrec ((test (lambda (i)
                                (iter (cons i try) (- n 1))
                                (if (< i 5)
                                    (test (+ i 1))))))
                (test 1))
            (if (and (distinct? try)
                     (apply (lambda (baker cooper fletcher miller smith)
                        (and (!= baker 5)
                             (!= cooper 1)
                             (!= fletcher 1)
                             (!= fletcher 5)
                             (> miller cooper)
                             (!= (abs (- smith fletcher)) 1)
                             (!= (abs (- fletcher cooper)) 1)))
                        try))
                (begin
                    (display 
                        (map (lambda (x y) (list x y))
                             (list 'baker 'cooper 'fletcher 'miller 'smith)
                             try))
                    (newline)))))
    (iter '() 5))

;; better solution
(define (multiple-dwelling)
    (for-each
        (lambda (try)
            (apply
                (lambda (baker cooper fletcher miller smith)
                    (if (and (!= baker 5)
                             (!= cooper 1)
                             (!= fletcher 1)
                             (!= fletcher 5)
                             (> miller cooper)
                             (!= (abs (- smith fletcher)) 1)
                             (!= (abs (- fletcher cooper)) 1))
                        (display (list baker cooper fletcher miller smith))))
                try))
        (permutations '(1 2 3 4 5))))

(multiple-dwelling)
