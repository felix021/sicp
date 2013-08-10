(define (below1 painter1 painter2)
  (let* ((split-point (make-vect 0 0.5))
         (paint-bottom
           (transform-painter4 painter1
                               (make-vect 0.0 0.0)
                               (make-vect 1.0 0.0)
                               split-point))
         (paint-top
           (transform-painter4 painter2
                               split-point
                               (make-vect 1.0 0.5)
                               (make-vect 0.0 1.0))))
    (lambda (frame)
      (begin
        (paint-bottom frame)
        (paint-top frame)))))
(paint (below1 wave wave))

(define (below2 painter1 painter2)
  (rotate90 ;from sicp.plt
    (beside1
      (rotate-270-degree painter1) ;from 2-50.scm
      (rotate-270-degree painter2))))
(paint (below2 wave wave))
