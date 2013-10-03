(include "3.5.3-pairs.scm")

(define (weighted-merge weighter s t)
    (if (stream-null? s)
        t
        (let ((ws (weighter (stream-car s)))
              (wt (weighter (stream-car t))))
            (if (< ws wt)
                (cons-stream
                    (stream-car s)
                    (weighted-merge weighter (stream-cdr s) t))
                (cons-stream
                    (stream-car t)
                    (weighted-merge weighter (stream-cdr t) s))))))

(define (weighted-pairs weighter s t)
    (cons-stream
        (list (stream-car s) (stream-car t))
        (weighted-merge
            weighter
            (stream-map (lambda (x) (list (stream-car s) x)) (stream-cdr t))
            (weighted-pairs weighter (stream-cdr s) (stream-cdr t)))))

(define (weighter-a pair)
    (apply + pair))

;(display-line (stream-head (weighted-pairs weighter-a integers integers) 10))

(define (weighter-b pair)
    (let ((i (car pair))
          (j (cadr pair)))
        (+ (* 2 i) (* 3 j) (* 5 i j))))

; 2/3/5的倍数什么的有点莫名其妙，这里就忽略了吧。。。

;(display (stream-head (weighted-pairs weighter-b integers integers) 10))
