(define (extended-cond? clause) (eq? (cadr clause) '=>)) 

(define (expand-clauses clauses)
    (if (null? clauses)
        'false              ; clause else no
        (let ((first (car clauses))
              (rest (cdr clauses)))
            (if (cond-else-clause? first)
                (if (null? rest)
                    (sequence->exp (cond-actions first))
                    (error "ELSE clause isn't last -- COND->IF" clauses))
                (make-if
                    (cond-predicate first)
                    (if (extended-cond? first)
                        (list (cadr actions) (cond-predicate first))
                        (sequence->exp (cond-actions first)))
                    (expand-clauses rest))))))
