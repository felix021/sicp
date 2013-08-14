
(define (count-pairs x)
    (if (not (pair? x))
        0
        (+ (count-pairs (car x))
           (count-pairs (cdr x))
           1)))

(define z1 (cons 'a 'b))
(define z2 (cons z1 z1))
(define z3 '(a b c))
(define z4 (cons 'a z2))
(define z7 (cons z2 z2))
(display (count-pairs z3)) (newline)
(display (count-pairs z4)) (newline)
(display (count-pairs z7 )) (newline)


(define c (list 'c))
(define b (cons 'b c))
(define a (cons 'a b))
(set-cdr! c a)
(display (count-pairs a)) (newline) ;loop forever or stack overflow

; 3: 
;   [a][+] (0+2+1)
;       |
;       +--> [b][+] (0+1+1)
;                |
;                +--> [c][/] (0+0+1)
;
; 4: 
;   [a][+] (0+3+1)
;       |
;       +--> [+][+] (1+1+1)
;             |  |
;             +--+--> [b][/] (0+0+1)
;
; 7: 
;   [+][+] (3+3+1)
;    |  |
;    +--+--> [+][+] (1+1+1)
;             |  |
;             +--+--> [b][/] (0+0+1)
;
; dead loop:
;   [a][+]
;    ↑  |
;    |  +--> [b][+]
;    |           |
;    |           +--> [c][+]
;    |                    |
;    +--------------------+
