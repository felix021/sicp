#lang racket

;; add-interval:
;;   (+ [x1 y1] [x2 y2])
;; = [(+ x1 x2) (y1 y2)]
;; 
;; width1 = (- y1 x1)
;; width2 = (- y2 x2)
;; ans_width = (- (+ y1 y2) (+ x1 x2))
;;           = (+ (- y1 x1) (- y2 x2))
;;           = (+ width1 width2)
;;
;; sub/mul/div ...
