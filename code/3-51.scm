(include "3.5.1-stream.scm")

(define (show x)
    (display-line x)
    x)

(define x (stream-map show (stream-enumerate-interval 0 10)))
; (stream-map show {0 (delay [1 10])}) ;; HERE [1 10] is short for (stream-enumerate-interval 1 10)
; {(show 0) (delay (stream-map show (stream-cdr {0 (delay [1 10])}) ))} 
; x = {0 (delay (stream-map show (stream-cdr {0 (delay [1 10])}) ))}; ouput 0

(newline)

(display-line (stream-ref x 5))
; (stream-ref (stream-cdr {0 (delay (stream-map show (s-cdr {0 (delay [1 10])})))}) 4)
; (stream-ref {(show 1) (delay (stream-map show (s-cdr {1 (delay [2 10])}) ))} 4) ; ouput 1
; (stream-ref {(show 2) (delay (stream-map show (s-cdr {2 (delay [3 10])}) ))} 3) ; ouput 2
; (stream-ref {(show 3) (delay (stream-map show (s-cdr {3 (delay [4 10])}) ))} 2) ; ouput 3
; (stream-ref {(show 4) (delay (stream-map show (s-cdr {4 (delay [5 10])}) ))} 1) ; ouput 4
; (stream-ref {(show 5) (delay (stream-map show (s-cdr {5 (delay [6 10])}) ))} 0) ; ouput 5
;
; value: 5
;
; x:
;   {0 (delay
;       {1 (delay
;           {2 (delay
;               {3 (delay
;                   {4 (delay
;                       {5 (delay
;                           (stream-map show (s-cdr {5 (delay [6 10])})) )} )} )} )} )} )}

(newline)

(display-line (stream-ref x 7))
; (stream-ref
;    (stream-cdr 
;       {0 (delay
;           {1 (delay
;               {2 (delay
;                   {3 (delay
;                       {4 (delay
;                           {5 (delay
;                               (stream-map show (s-cdr {5 (delay [6 10])})) )} )} )} )} )} )} )
;    7)
;
; (stream-ref {(show 6) (delay (stream-map show (s-cdr {6 (delay [7 10])})))} 1) ; ouput 6
; (stream-ref {(show 7) (delay (stream-map show (s-cdr {7 (delay [8 10])})))} 0) ; ouput 7
;
; value: 7

;; 解释：在Guile/MIT-Scheme中，delay 和 force 的行为实际上类似于
#|
(define-syntax delay 
    (syntax-rules ()
        [(delay expr) (cons 'promise (lambda () expr) )]))

(define (force promise)
    (let*
        ((func (cdr promise))
         (value (func)))
        (set-cdr! promise (lambda () value))
        value))
|#

;; 也就是说，force是有副作用的，实际上已经将promise计算结果记忆下来了，使得下一次使用这个promise时不必再执行一次计算过程。但是这也意味着，传递给delay的form不应该具有任何副作用，否则会产生非预期的结果。(或者使用类似习题3-27的memorize函数来实现)

;; 这里有一个解释delay和force的文档，以及一些很有意思的stream的例子。http://people.cs.aau.dk/~normark/prog3-03/html/notes/eval-order_themes-delay-stream-section.html
