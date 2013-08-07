#lang racket

;; a) 不断递归地转换 complex->complex
;; b) 没有。出现这种情况是因为找不到 '(complex complex) 的对应操作
;; c) 如下

(define (apply-generic op . args)
    (let*
        ((type-tags (map type-tag args))
         (proc (get op type-tags)))
        (if proc
            (apply proc (map contents args))
            (if (= (length args) 2)
                (let*
                    ((type1 (car type-tags))
                     (type2 (cadr type-tags))
                     (a1 (car args))
                     (a2 (cadr args))
                     (t1->t2 (get-coercion type1 type2))
                     (t2->t1 (get-coercion type2 type1)))
                    (cond
                        ;; 多加这一个条件就好了
                        ((eq? type1 type2) (error "no method for same type: " (list op type-tags)))
                        (t1->t2 apply-generic op (t1->t2 a1) a2)
                        (t2->t1 apply-generic op a1 (t2->t1 a2))
                        (else (error "no method to coerce types: " (list op type-tags)))))
                (error "no method for these types: " (list op type-tags))))))
