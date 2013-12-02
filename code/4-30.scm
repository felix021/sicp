(define (eval-sequence exps env)
    (cond
        ((last-exp? exps) (eval (first-exp exps) env))
        (else
            (actual-value (first-exp exps) env)
            (eval-sequence (rest-exps exps) env))))

; a)
(define (for-each proc items)
    (if (null? items)
        'done
        (begin
            (proc (car items))
            (for-each proc (cdr items)))))

;input
(for-each (lambda (x) (newline) (display x)) (list 57 321 88))

57
321
88
;value
done

; 解释：x是传递给primitive procedure(display)的，会被求值。

; b)
(define (p1 x)
    (set! x (cons x '(2)))
    x)

(define (p2 x)
    (define (p e)
        e
        x)
    (p (set! x (cons x '(2)))))

; 原eval-sequence
(p1 1) => (list 1 2) ;因为set!是primitive procedure
(p2 1)
    (eval (p (set! x (cons x '(2)))) ENV[x=1])
        ;ENV1[e:(list 'thunk '(cons x '(2)) ENV[x=1])] --> ENV[x=1]
        (eval 'e ENV1) => (list 'thunk '(cons x '(2)) ENV[x=1])
        ;ENV1[e:(list 'thunk '(cons x '(2)) ENV[x=1])] --> ENV[x=1]
        x => 1

; 新eval-sequence
(p1 1) => (list 1 2)
(p2 1)
    (eval (p (set! x (cons x '(2)))) ENV[x=1])
        ;ENV1[e:(list 'thunk '(cons x '(2)) ENV[x=1])] --> ENV[x=1]
        (actual-value 'e ENV1) => 'done
        ;ENV1[e:(list 'evaluated-thunk 'done), x:(list 1 2)] --> ENV[x=1]
        x => (list 1 2)

; c)
; 解释：新版本的eval-sequence与旧版本的区别在于如果序列中任意语句的返回值是槽，都会被求值。
;        a 中代码display的返回值显然不是thunk，因此不受影响。

; d)
; 似乎Cy的处理方法更合理。
