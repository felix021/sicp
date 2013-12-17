; 比如说当 i = 4, j = 5 的情况下，没有能够满足条件的 k ，如果使用流，会导致try-again不断给出新的不满足的 k ，因此无法得出结果。

;; low <= k <= j <= i < infinite
(define (a-pythagorean-triple-from low)
    (let* ((i (an-integer-starting-from low)) ; "high" is infinite
           (j (an-integer-between low i))
           (k (an-integer-between low j)))
        (require (= (+ (* i i) (* j j) (* k k))))
        (list i j k)))
