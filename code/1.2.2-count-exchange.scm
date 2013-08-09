#lang racket

;;   cc(x, [a, b, c, d, e])
;; = cc(x, [b, c, d, e])
;; + cc(x - a, [a, b, c, d, e])

(define (count-exchange amount)
    (define (face-value-of kind)
        (cond
            ((= kind 1) 1)
            ((= kind 2) 5)
            ((= kind 3) 10)
            ((= kind 4) 25)
            ((= kind 5) 50)
            (else (error "unknown kind: " kind))))

    (define (cc amount kinds-of-coins)
        (cond
            ((= amount 0) 1)
            ((= kinds-of-coins 0) 0)
            ((< amount 0) 0)
            (else
                (+
                    (cc amount (- kinds-of-coins 1))
                    (cc (- amount (face-value-of kinds-of-coins)) kinds-of-coins)))))

    (cc amount 5))

(count-exchange 100)
