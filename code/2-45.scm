(define (split op1 op2)
  (lambda (painter n)
    (if (= n 0)
      painter
      (let ((smaller ((split op1 op2) painter (- n 1))))
        (op1 painter (op2 smaller smaller))))))

(define right-split-new (split beside below))

(define up-split-new (split below beside))

;(paint (right-split-new wave 4))
;;(paint (up-split-new wave 4))
