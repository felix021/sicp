(define (D x) (display x) (newline))

; set based on binary-tree

(define (make-set) '(*set*))

(define (make-node key value left right)
    (cons (cons key value) (cons left right)))

(define (node-key node) (caar node))
(define (node-value node) (cdar node))
(define (node-left node) (cadr node))
(define (node-right node) (cddr node))

(define (node-set-key! node key) (set-car! (car node) key))
(define (node-set-value! node value) (set-cdr! (car node) value))
(define (node-set-left! node left) (set-car! (cdr node) left))
(define (node-set-right! node right) (set-cdr! (cdr node) right))

(define (element-of-set? key set)
    (define (find-in elements)
        (if (null? elements)
            #f
            (let ((nkey (node-key elements))
                  (value (node-value elements))
                  (left (node-left elements))
                  (right (node-right elements)))
                (cond
                    ((= key nkey) value)
                    ((< key nkey) (find-in left))
                    ((> key nkey) (find-in right))))))
    (find-in (cdr set)))

(define (adjoin-set key value set)
    (define (new-node) (make-node key value '() '()))
    (define (insert! elements)
        (let ((nkey (node-key elements))
              (left (node-left elements))
              (right (node-right elements)))
            (cond
                ((= key nkey) (node-set-value! elements value))
                ((< key nkey)
                    (if (null? left)
                        (node-set-left! elements (new-node))
                        (insert! left)))
                ((> key nkey)
                    (if (null? right)
                        (node-set-right! elements (new-node))
                        (insert! right))))))
    (if (null? (cdr set))
        (set-cdr! set (new-node))
        (insert! (cdr set))))

(define (dump-set set)
    (define (n-spaces n)
        (display "  ")
        (if (> n 0)
            (n-spaces (- n 1))
            #t))
    (define (dump depth elements)
        (cond
            ((not (null? elements))
                (n-spaces depth)
                (let ((nkey (node-key elements))
                      (value (node-value elements))
                      (left (node-left elements))
                      (right (node-right elements)))
                    (display nkey) (display ": ") (display value) (newline)
                    (dump (+ 1 depth) left)
                    (dump (+ 1 depth) right)))))
    (dump 0 (cdr set))
    (newline))
        
;; test
#|
(define s (make-set))
(adjoin-set 3 'a s)
(adjoin-set 1 'b s)
(adjoin-set 0 'c s)
(adjoin-set 2 'd s)
(dump-set s)
(adjoin-set 5 'e s)
(adjoin-set 4 'f s)
(adjoin-set 6 'g s)
(adjoin-set 5.5 'ee s)
(dump-set s)
(adjoin-set 8 'h s)
(adjoin-set 7 'i s)
(adjoin-set 9 'j s)
(dump-set s)
(D (element-of-set? 3 s))
(D (element-of-set? 5 s))
(D (element-of-set? 7 s))
(D (element-of-set? 9 s))
(D (element-of-set? 11 s))
;|#

(define make-table make-set)

(define (lookup key table) (element-of-set? key table))

(define (insert! key value table) (adjoin-set key value table))

(define dump-table dump-set)
