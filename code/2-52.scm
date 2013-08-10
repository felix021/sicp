; a) 多加几个 (make-vect x y) 就行, pass

; b) 与原图的结果略有不同
(define (corner-split-2-52b painter n)
  (if (= n 0)
    painter
    (let* ((up (up-split painter (- n 1)))
           (right (right-split painter (- n 1)))
           (corner (corner-split painter (- n 1))))
      (beside (below painter up)
              (below right corner)))))
(paint-hi-res (corner-split-2-52b wave 4))

; c) 把painter反过来以后再交给square-limit最简单XD
(define (square-limit-2-52c painter n)
    (square-limit (flip-horiz painter) n))
(paint-hi-res (square-limit-2-52c wave 4))

