#lang racket

(define (gcd a b)
    (display a) (display ", ") (display b) (newline)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

(gcd 206 40)

;; 应用序
;; (gcd 206 40)
;; (gcd 40 6)
;; (gcd 6 4)
;; (gcd 4 2)
;; (gcd 2 0)
;; 2

;; 正则序
;; (gcd 206 40)
;; (gcd 40 (% 206 40)))
;; (gcd (% 206 40) (% 40 (% 206 40)))
;; ... (refer to http://sicp.readthedocs.org/en/latest/chp1/20.html)
