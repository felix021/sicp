
(define (sqrt-stream x)
    (cons-stream 1.0
        (stream-map
            (lambda (guess)
                (sqrt-improve guess x))
            (sqrt-stream x))))
                
;; 这个版本的 sqrt-stream 计算第i个元素的时候，要递归地计算以第i-1个元素开头的stream，导致效率过低。使用原先版本的sqrt-stream可以则始终依赖于同一个stream，由于有记忆过程，所以效率是O(n)的。
