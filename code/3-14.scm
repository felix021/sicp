(define (mystery x)
    (define (loop x y)
        (if (null? x)
            y
            (let ((temp (cdr x)))
                (set-cdr! x y)
                (loop temp x))))
    (loop x '()))

(define v '(a b c))
(define w (mystery v))
(display v) (newline) ; (a)
(display w) (newline) ; (c b a)

; reverse a list.

; (mystery '(a b c))                    ; v: [a]->[b]->[c]->nil
;   (loop x=(a b c) y=())               ; x: v, y: nil
;       [temp: (b c)]                   ; temp: [b]->[c]->nil
;       [x: '(a)]                       ; x/v: [a]->nil
;       (loop x=(b c) y=(a))            ; x: [b]->[c]->nil, y->[a]->nil
;           [temp: (c)]                 ; temp: [c]->nil
;           [x: (b a)]                  ; x: [b]->(v)[a]->nil
;           (loop x=(c) y=(b a))        ; x: [c]->nil, y: [b]->(v)[a]->nil
;               [temp: ()]              ; temp: nil
;               [x: (c b a)]            ; x: [c]->(y)[b]->(v)[a]->nil
;               (loop x=() y=(c b a))   ; x: nil, y: [c]->[b]->(v)[a]->nil
;                   '(c b a)            ; return y
