#lang racket

(require "felix.scm")
(require "huffman.scm")
(require "2-68.scm")
(require "2-69.scm")

(define (var n)
    (string->symbol (string-append "A" (number->string n))))

(define (make-pairs n)
    (map
        (lambda (i)
            (list (var i) (expt 2 i)))
        (range 0 (dec n) 1)))

(generate-huffman-tree (make-pairs 5))
;    (31
;      (leaf A4 16)     ;0
;      (15
;        (leaf A3 8)    ;10
;        (7
;          (leaf A2 4)  ;110
;          (3
;            (leaf A1 2);1110
;            (leaf A0 1);1111
;          ))))

(generate-huffman-tree (make-pairs 10))

;最频繁: 1个bit，最不频繁(n - 1)个
