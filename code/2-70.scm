#lang racket

(require "huffman.scm")
(require "2-68.scm")
(require "2-69.scm")

(define tree 
    (generate-huffman-tree 
        '((A 2) (NA 16) (BOOM 1) (SHA 3) (GET 2) (YIP 9) (JOB 2) (WAH 1))))

(define msg
    '(GET A JOB
        SHA NA NA NA NA NA NA NA NA
        GET A JOB
        SHA NA NA NA NA NA NA NA NA
        WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
        SHA BOOM))

(length (encode msg tree)) ;84
(* 3 (length msg)) ;108
