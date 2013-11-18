; 停机问题

(define (run-forever) (run-forever))

(define (try p)
    (if (halts? p p)
        (run-forever)
        'halted))

; 假设停机问题可解，即存在过程 H: (H P I) 可以判定程序P在输入I的情况下是否可停机。假设P在输入I的情况下可停机，则H输出true(停机)，否则输出false(死循环)，即可导出矛盾：
;
; 由于程序本身可以当作数据，因此可以被当作输入；故H应该可以判定将P作为P的输入时，P是否会停机。所以假设过程K:
;
;   (define (K P)
;       (if (H P P)
;           false
;           true))
;
; 即(K P)与(H P P)的行为相反。
;
; 现在假设求 (K K) ，若 (H K K) 输出停机，则 (K K) 为死循环，而二者矛盾（因为(H K K)的定义就是(K K)的行为），因此停机问题不可解。
