(include "3.5.2.scm")

(define (integrate-series stream)
    (stream-map / stream integers))

(define exp-series
    (cons-stream 1 (integrate-series exp-series)))

;(display-line (stream-head exp-series 5))

;; 正确答案 from http://community.schemewiki.org/?sicp-ex-3.59
;;     其实没怎么看懂，导数积分什么的 太麻烦了……
(define sine-series (cons-stream 0 (integrate-series cosine-series)))
(define cosine-series (cons-stream 1 (integrate-series (scale-stream sine-series -1))))

;(display-line (stream-head cosine-series 10))
;(display-line (stream-head sine-series 10))


;; 下面这个是我自己的答案，虽然能计算出系数，但是并不是按x^i给出。

; cosine:       1       -1/2        1/(432)     -1/(65432)
; sine:   0     1       -1/(32)     1/(5432)    -1/(765432)

#|
(define cosine-series
    (cons-stream 1 (stream-map
                        /
                        (stream-cdr sine-series)
                        (scale-stream (stream-filter even? (integers-starting-from 2)) -1))))

(define sine-series
    (cons-stream 0 (stream-map
                        /
                        cosine-series
                        (stream-filter odd? (integers-starting-from 1)))))

;(display-line (stream-head cosine-series 5))
;(display-line (stream-head sine-series 5))
|#
