
(define (a-pythagorean-triple-between low high)
    (let ((i (an-integer-between low high)))
          (hsq (* high high))
        (let ((j (an-integer-between i high))
              (ksq (+ (* i i) (* j j))))
            (require (>= hsq ksq))
            (let ((k (sqrt ksq)))
                (require (integer? k))
                (list i j k)))))

; 如果是要枚举[low, high]区间的所有毕达哥拉斯三元组，那么这个作法的确更快了，把时间复杂度从O(N^3)下降到O(N^2)
; 对于单次调用而言则有可能出现后者更慢（例如3,4,5）
