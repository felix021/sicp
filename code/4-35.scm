(define (an-integer-between a b)
    (require (<= a b))
    (amb a (an-integer-between (+ a 1) b)))

;; low <= i <= j <= k <= high
(define (a-pythagorean-triple-between low high)
    (let* ((i (an-integer-between low high))
           (j (an-integer-between i high))
           (k (an-integer-between j high)))
        (require (= (+ (* i i) (* j j) (* k k))))
        (list i j k)))

