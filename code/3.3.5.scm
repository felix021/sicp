(define (dd x) (display x) (newline))

(define true #t)
(define false #f)

(define (inform-about-value constraint) (constraint 'I-have-a-value))
(define (inform-about-no-value constraint) (constraint 'I-lost-my-value))

(define (has-value? connector) (connector 'has-value?))

(define (get-value connector) (connector 'value))

(define (set-value! connector new-value informant)
    ((connector 'set-value!) new-value informant))

(define (forget-value! connector retractor)
    ((connector 'forget) retractor))

(define (connect connector new-constraint)
    ((connector 'connect) new-constraint))

(define (for-each-except exception procedure lst)
    (define (loop items)
        (cond
            ((null? items) 'done)
            ((eq? (car items) exception) (loop (cdr items)))
            (else
                (procedure (car items))
                (loop (cdr items)))))
    (loop lst))

(define (make-connector)
    (let ((value false) (informant false) (constraints '()))
        (define (set-my-value newval setter)
            (cond
                ((not (has-value? me))
                    (set! value newval)
                    (set! informant setter)
                    (for-each-except setter
                        inform-about-value
                        constraints))
                ((not (= value newval))
                    (error "Contradiction - make-connector.set-my-value: " (list value newval)))
                (else 'ignored)))
        (define (forget-my-value retractor)
            (if (eq? retractor informant)
                (begin
                    (set! informant false)
                    (for-each-except retractor
                        inform-about-no-value
                        constraints))
                'ignored))
        (define (connect new-constraint)
            (if (not (memq new-constraint constraints))
                (set! constraints
                    (cons new-constraint constraints)))
            (if (has-value? me)
                (inform-about-value new-constraint))
            'done)
    (define (me request)
        (cond
            ((eq? request 'has-value?) (if informant true false))
            ((eq? request 'value) value)
            ((eq? request 'set-value!) set-my-value)
            ((eq? request 'forget) forget-my-value)
            ((eq? request 'connect) connect)
            (else (error "Unkown operation -- CONNECTOR" request))))
    me))

(define (adder a1 a2 sum)
    (define (process-new-value)
        (cond
            ((and (has-value? a1) (has-value? a2))
                (set-value! sum
                    (+ (get-value a1) (get-value a2))
                    me))
            ((and (has-value? a1) (has-value? sum))
                (set-value! a2
                    (- (get-value sum) (get-value a1))
                    me))
            ((and (has-value? a2) (has-value? sum))
                (set-value! a1
                    (- (get-value sum) (get-value a2))
                    me))))
    (define (process-forget-value)
        (forget-value! sum me)
        (forget-value! a1 me)
        (forget-value! a2 me)
        (process-new-value))
    (define (me request)
        (cond
            ((eq? request 'I-have-a-value) (process-new-value))
            ((eq? request 'I-lost-my-value) (process-forget-value))
            (else (error "unknown request -- ADDER.me" request))))
    (connect a1 me)
    (connect a2 me)
    (connect sum me)
    me)

(define (multiplier m1 m2 product)
    (define (process-new-value)
        (cond
            ((or (and (has-value? m1) (= (get-value m1) 0))
                 (and (has-value? m2) (= (get-value m2) 0)))
                (set-value! product 0 me))
            ((and (has-value? m1) (has-value? m2))
                (set-value! product
                    (* (get-value m1) (get-value m2))
                    me))
            ((and (has-value? m1) (has-value? product))
                (set-value! m2
                    (/ (get-value product) (get-value m1))
                    me))
            ((and (has-value? m2) (has-value? product))
                (set-value! m1
                    (/ (get-value product) (get-value m2))
                    me))))
    (define (process-forget-value)
        (forget-value! product me)
        (forget-value! m1 me)
        (forget-value! m2 me)
        (process-new-value))
    (define (me request)
        (cond
            ((eq? request 'I-have-a-value) (process-new-value))
            ((eq? request 'I-lost-my-value) (process-forget-value))
            (else (error "unknown request -- MULITPLIER.me" request))))
    (connect m1 me)
    (connect m2 me)
    (connect product me)
    me)

(define (constant value connector)
    (define (me request)
        (error "unknown request -- CONSTANT.me" request))
    (connect connector me)
    (set-value! connector value me)
    me)

(define (probe name connector)
    (define (print-probe value)
        (newline)
        (display "Probe: ")
        (display name)
        (display " = ")
        (display value))
    (define (process-new-value)
        (print-probe (get-value connector)))
    (define (process-forget-value)
        (print-probe "?"))
    (define (me request)
        (cond
            ((eq? request 'I-have-a-value) (process-new-value))
            ((eq? request 'I-lost-my-value) (process-forget-value))
            (else (error "unknown request -- PROBE.me" request))))
    (connect connector me)
    me)

;; simple test of adder and probe
#|
(define a (make-connector))
(define b (make-connector))
(define c (make-connector))

(adder a b c)

(probe "a" a)
(probe "b" b)
(probe "c" c)

(set-value! a 3 'user)
(set-value! b 4 'user)

(forget-value! b 'user)
(set-value! c 8 'user)
|#

#|

(define (celsius-fahrenheit-converter c f)
    (let ((u (make-connector))
          (v (make-connector))
          (w (make-connector))
          (x (make-connector))
          (y (make-connector)))
     (multiplier c w u)
     (multiplier v x u)
     (adder v y f)
     (constant 9 w)
     (constant 5 x)
     (constant 32 y)
    'ok))

(define C (make-connector))
(define F (make-connector))

(celsius-fahrenheit-converter C F)

(probe "Celsius temp" C)
(probe "Fahrenheit temp" F)

(set-value! C 25 'user)

;(set-value! F 212 'user) ;this line causes error

(forget-value! C 'user)

(set-value! F 212 'user)
;|#
