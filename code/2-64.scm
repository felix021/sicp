#lang racket

(require "set-tree.scm")

(provide list->tree)

(define (list->tree lst)
    (car (partial-tree lst (length lst))))

(define (partial-tree elts n)
    (if (= n 0)
        (cons '() elts)
        (let* 
            ((left-size (quotient (- n 1) 2))
             (left-result (partial-tree elts left-size))
             (left-tree (car left-result))
             (non-left-elts (cdr left-result))
             (right-size (- n left-size 1))
             (this-entry (car non-left-elts))
             (right-result (partial-tree (cdr non-left-elts) right-size))
             (right-tree (car right-result))
             (remaining-elts (cdr right-result)))
            (cons
                (make-tree this-entry left-tree right-tree)
                remaining-elts))))

;(list->tree '(1 3 5 7 9 11 13))

; 该算法 (partial-tree elts n) 的含义是，从 elts 中取出 n 个元素组成一棵
; 子树sub-tree, 和剩下未处理元素拼起来返回 (cons sub-tree remaining-elts)
;
; sub-tree的生成过程是：
;
;   把需要处理的n个元素拆分成3段 (left entry right)
;   其中:
;       left  包含 left_size = (n - 1) / 2 个元素
;       entry 是当前子树的entry（1个元素）
;       right 则包含 right_size = n - left_size - 1 个元素
;
;   接着：
;       计算 (partial-tree elts left_size) 的返回值 (left-tree non-left-elts)
;       计算 (partial-tree non-left-elts right-size) 的返回值 (right-tree remaining-elts)
;       拼 sub-tree: (make-tree entry left-tree right-tree)
;       拼返回值 (cons sub-tree remaining-elts)
;
; 其中比较奇怪的一点是每次返回剩余未处理元素
; 这样的确避免了用take/drop从原数组中拷贝元素
; 在一定程度上提高了效率，但是却降低了可读性

; 下面这个版本效率略低些（每个元素多拷贝一次，但仍然是O(n)），可读性相对更好。

(define (list->tree1 elements)
    (if (null? elements)
        '()
        (let*
            ((n (length elements))

             (left-size (quotient (- n 1) 2))
             (right-size (- n left-size 1))

             (left-elements (take elements left-size))
             (non-left-elements (drop elements left-size))
             (entry (car non-left-elements))
             (right-elements (cdr non-left-elements)))

            (make-tree
                entry
                (list->tree1 left-elements)
                (list->tree1 right-elements)))))

;(list->tree1 '(1 3 5 7 9 11 13))

