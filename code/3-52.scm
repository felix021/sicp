(include "3.5.1-stream.scm")

(define sum 0)

(define (accum x)
    (set! sum (+ x sum))
    sum)

(define seq (stream-map accum (stream-enumerate-interval 1 20)))
; (stream-map accum {1 (delay [2 20])})
; { (accum 1) (delay (stream-map accum {2 (delay [3 20])} )) } ;; sum = 1
; value: {1 (delay (stream-map accum {2 (delay [3 20]) )) }

(display "sum: ")
(display-line sum) ; 1

(define y (stream-filter even? seq))
; (stream-filter even? {1 (delay ...)} )
; (stream-filter even? (force (delay (stream-map accum {2 (delay [3 20])}))))
; (stream-filter even? { (accum 2) (delay (stream-map accum {3 (delay [4 20])} )) } ) ;; sum = sum + 2 = 3
; (stream-filter even? { (accum 3) (delay (stream-map accum {4 (delay [5 20])} )) } ) ;; sum = sum + 3 = 6
;                      ------------------------------------------------------------
;                                                   v
; { 6 (delay stream-filter? even? (stream-cdr! {3 (delay (stream-map (accum {4 (delay [5 20])} ))) })) }

(display "sum: ")
(display-line sum) ;6

(define mod5? (lambda (x) (= (remainder x 5) 0)))

(define z (stream-filter mod5? seq))
; (stream-filter mod5? {1 3 6 (delay (filter-even (map-accum (enumerate 4 10))))}
; ...
; (filter-mod5 {(accum 4) (filter-even (map-accum (enumerate 5 10)))}) ;; sum = sum + 4 = 10
;

(display "sum: ")
(display-line sum) ;10

(stream-ref y 7) ;value: 136
; {1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 [17 20]}
; seq: {1 3 6 10 15 21 28 36 45 55 66 78 91 105 120 136 [...]} 
; y: {6 10 28 36 66 78 120 136}
; sum = 136

(display "sum: ")
(display-line sum) ;136

(display-stream z)
; seq: { ... 120 136 153 171 190 210}
; z: {10 15 45 55 105 120 190 210}
; sum = 210
;
(display "sum: ")
(display-line sum) ;210


;; stream-ref 的值为136，display-stream会输出 z = {10..210}
;; 如果delay的实现没有优化，那么sum会被多次加入，而且因为 define seq/y/z 的时候实际上已经计算了一些，因此sum的结果会很诡异。
;; 无记忆的delay和force实现供参考
#|
(define-syntax delay
     (syntax-rules ()
          [(delay x) (lambda () x)]))

(define (force promise)
     (promise))
|#
