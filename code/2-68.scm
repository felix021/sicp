#lang racket
(require "huffman.scm")

(provide 
    encode
    encode-symbol
)

(define (encode-symbol symbol tree)
    (define (iter answer branch)
        (if (leaf? branch)
            (if (eq? (symbol-leaf branch) symbol)
                (reverse answer) ;append效率低，so后面用cons，so这里得reverse
                '())
            (let ((left-answer (iter (cons 0 answer) (left-branch branch))))
                (if (not (null? left-answer))
                    left-answer
                    (iter (cons 1 answer) (right-branch branch))))))
    (let ((ans (iter '() tree)))
        (if (null? ans)
            (error "symbol not found in tree: " symbol)
            ans)))

(define (encode message tree)
    (if (null? message)
        '()
        (append (encode-symbol (car message) tree)
                (encode (cdr message) tree))))

(define sample-tree
    (make-code-tree
        (make-leaf 'A 4)
        (make-code-tree
            (make-leaf 'B 2)
            (make-code-tree
                (make-leaf 'D 1)
                (make-leaf 'C 1)))))

;(encode-symbol 'A sample-tree)
;(encode-symbol 'B sample-tree)
;(encode-symbol 'C sample-tree)
;(encode-symbol 'D sample-tree)
;(encode-symbol 'E sample-tree)
;(encode '(A D A B B C A) sample-tree)
