; 4-24.test1.scm

(define (loop n)
    (if (> n 0)
        (loop (- n 1))))

(loop 1000000)
(exit)


; 4-24.test2.scm

(define (fib n)
    (if (<= n 2)
        1
        (+ (fib (- n 1)) (fib (- n 2)))))

(fib 30)
(exit)

;; 4-24.wrapper1.scm
(define dont-run 1)
(include "4.1.scm")

(define start (get-internal-real-time))
(driver-loop)
(define end (get-internal-real-time))
(display (/ (- end start) 1000000000.0))

;; 4-24.wrapper2.scm
(define dont-run-all 1)
(include "4.1.7.scm")

(define start (get-internal-real-time))
(driver-loop)
(define end (get-internal-real-time))
(display (/ (- end start) 1000000000.0))

;;
;; tests:
;;
;; guile 4-24.wrapper1.scm < 4-24.test1.scm
;; guile 4-24.wrapper2.scm < 4-24.test1.scm
;; ==> 9.689208264 v.s. 5.527926879
;;
;; guile 4-24.wrapper1.scm < 4-24.test2.scm
;; guile 4-24.wrapper2.scm < 4-24.test2.scm
;; ==> 18.879867235 v.s. 10.682171467
;;

;; 结论?
