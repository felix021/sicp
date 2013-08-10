;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 2.2.4-picture-language) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
(require (planet soegaard/sicp:2:1/sicp))

(define wave einstein)

(define wave2 (beside wave (flip-vert wave)))
;(paint wave2)

(define wave4 (below wave2 wave2))
;(paint wave4)

(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))
;(paint (flipped-pairs wave))

;-----------------;

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))
;(paint (right-split wave 4))


;; 2-44.scm
(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))
;(paint (up-split wave 4))


(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))
;(paint-hi-res (corner-split wave 4))

(define (corner-split-2-52b painter n)
  (if (= n 0)
      painter
      (let* ((up (up-split painter (- n 1)))
             (right (right-split painter (- n 1)))
             (corner (corner-split painter (- n 1))))
          (beside (below painter up)
                  (below right corner)))))
;(paint-hi-res (corner-split-2-52b wave 4))


(define (square-limit painter n)
  (let* ((RU (corner-split painter n))
         (LU (flip-horiz RU))
         (RB (flip-vert RU))
         (LB (flip-vert LU)))
    (below (beside LB RB)
           (beside LU RU))))
(paint-hi-res (square-limit wave 4))

(define (square-limit-2-52c painter n)
    (square-limit (flip-horiz painter) n))
(paint-hi-res (square-limit-2-52c wave 4))

;-----------------;

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define flipped-pairs-new (square-of-four identity flip-vert identity flip-vert))
;(paint (flipped-pairs-new wave))

(define square-limit-new (square-of-four flip-horiz identity rotate180 flip-vert))
;(paint (square-limit-new (corner-split wave 4)))

;-----------------;

;; 2-45
(define (split op1 op2)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller ((split op1 op2) painter (- n 1))))
          (op1 painter (op2 smaller smaller))))))

(define right-split-new (split beside below))

(define up-split-new (split below beside))

;(paint (right-split-new wave 4))
;(paint-hires (up-split-new wave 4))

;-----------------;
;; frame

;; this function is in sicp.plt
#|
(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))
|#

;---------------;
;2-46

; (define (make-vect x y) (cons x y)) ;; provided in sicp.plt

(define (xcor-vect v) (car v))
(define (ycor-vect v) (cdr v))

(define (add-vect v1 v2)
  (make-vect
   (+ (xcor-vect v1) (xcor-vect v2))
   (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect
   (- (xcor-vect v1) (xcor-vect v2))
   (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect v s)
  (make-vect (* s (xcor-vect v)) (* s (ycor-vect v))))

;-----------------;
; this procedure is provbuhided in sicp.plt
#|
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))
|#

;----------------;

; origin:  (0, 0)
; corner1: (1, 0)
; corder2: (0, 1)

(define (transform-painter4 painter origin corner1 corner2)
  (lambda (frame)
    (let* ((m (frame-coord-map frame))
           (new-origin (m origin)))
      (painter
       (make-frame new-origin
                   (sub-vect (m corner1) new-origin)
                   (sub-vect (m corner2) new-origin))))))
;(paint einstein)

; the provided 'transform-painter' accepts 3 arguments: 
;    origin corner1 corner2
; and returns a proc to transform painter.

(define flip-vertical
  (transform-painter (make-vect 0 1)
                     (make-vect 1 1)
                     (make-vect 0 0)))
;(paint (flip-vertical einstein))

;2-50
(define flip-horizontal
  (transform-painter (make-vect 1 0)
                     (make-vect 0 0)
                     (make-vect 1 1)))
;(paint (flip-horizontal einstein))

(define rotate-180-degree
  (transform-painter (make-vect 1 1)
                     (make-vect 0 1)
                     (make-vect 1 0)))
;(paint (rotate-180-degree einstein))

(define rotate-270-degree
  (transform-painter (make-vect 0 1)
                     (make-vect 0 0)
                     (make-vect 1 1)))
;(paint (rotate-270-degree einstein))


(define shrink-to-upper-right
  (transform-painter (make-vect 0.5 0.5)
                     (make-vect 1 0.5)
                     (make-vect 0.5 1)))
;(paint (shrink-to-upper-right einstein))

(define rotate-90-degree
  (transform-painter (make-vect 1 0)
                     (make-vect 1 1)
                     (make-vect 0 0)))
;(paint (rotate-90-degree einstein))

;; this procedure would fail (due to bug?)
(define squash-inwards
  (transform-painter (make-vect 0 0)
                     (make-vect 0.65 0.35)
                     (make-vect 0.35 0.65)))
;(paint (squash-inwards einstein))

(define (beside1 painter1 painter2)
  (let* ((split-point (make-vect 0.5 0.0))
         (paint-left
          (transform-painter4 painter1
                              (make-vect 0.0 0.0)
                              split-point
                              (make-vect 0.0 1.0)))
         (paint-right
          (transform-painter4 painter2
                              split-point
                              (make-vect 1.0 0.0)
                              (make-vect 0.5 1.0))))
    (lambda (frame)
      (begin
        (paint-left frame)
        (paint-right frame)))))

;(paint (beside1 wave wave))

;2-51
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
;(paint (below1 wave wave))

(define (below2 painter1 painter2)
  (rotate90
   (beside1
    (rotate-270-degree painter1)
    (rotate-270-degree painter2))))
;(paint (below2 wave wave))
