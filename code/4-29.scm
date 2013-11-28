; a) 有记忆：0.43s, 没记忆：9.3s
(define (fib i)
    (if (<= i 2)
        1
        (+ (fib (- i 1)) (fib (- i 2)))))

(define (test x)
    (define (iter t)
        (if (= t 0)
            0
            (+ x (iter (- t 1)))))
    (iter 10))

(test (fib 20))

(exit)

; b)
(define count 0)

(define (id x) (set! count (+ 1 count)) x)

(define (square x) (* x x))

;input
(square (id 10))

;value
100

;input
count

;value
1 ;有记忆, (id 10)只会被eval一次
2 ;没记忆
