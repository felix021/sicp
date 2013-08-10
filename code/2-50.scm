; the 'transform-painter' in (planet sicp.plt) accepts 3 arguments: 
;    origin corner1 corner2
; and returns a proc to transform painter.

(define flip-horizontal
  (transform-painter (make-vect 1 0)
                     (make-vect 0 0)
                     (make-vect 1 1)))
(paint (flip-horizontal einstein))

(define rotate-180-degree
  (transform-painter (make-vect 1 1)
                     (make-vect 0 1)
                     (make-vect 1 0)))
(paint (rotate-180-degree einstein))

(define rotate-270-degree
  (transform-painter (make-vect 0 1)
                     (make-vect 0 0)
                     (make-vect 1 1)))
(paint (rotate-270-degree einstein))
