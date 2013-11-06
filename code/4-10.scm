; 例如另一种语法是将函数名放在最后:
;   (1 2 3 +)
; 

(define (last-element lst)
    (if (null? (cdr lst))
        (car lst)
        (last-element (cdr lst))))

(define (all-except-last lst)
    (if (null? (cdr lst))
        '()
        (cons (car lst) (all-except-last (cdr lst)))))

(define (tagged-list? exp sym)
    (if (pair? exp)
        (let ((last (last-element exp)))
            (eq? last sym))
        #f))

(define (if? exp) (tagged-list? exp 'if))

(define (if-predicate exp) (car exp))

(define (if-consequent exp) (cadr exp))

(define (if-alternative exp)
    (if (= (length exp) 4)
        (caddr exp)
        'false))

; ...
