#lang racket

(define my-rand
    (let*
        ((random-init 0)
         (rand-update (lambda (x) (remainder (+ (+ x 65537) 1027) 1048575)))
         (x random-init))
        (lambda ()
            (set! x (rand-update x))
            x)))

;(rand) (rand) (rand) (rand) (rand) (rand) (rand) (rand) (rand)

(define (rand)
    (floor (* (random) 1048576)))

(define (cesaro-test)
    (= (gcd (rand) (rand)) 1))

(define (monte-carlo trials experiment)
    (define (iter trials-remaining trials-passed)
        (cond
            ((= trials-remaining 0) (/ trials-passed trials))
            ((experiment)
                (iter (- trials-remaining 1) (+ trials-passed 1)))
            (else
                (iter (- trials-remaining 1) trials-passed))))
    (iter trials 0))

(define (estimaet-pi trials)
    (sqrt (/ 6 (monte-carlo trials cesaro-test))))

(estimaet-pi 10000)
