; eva?
;
; 使用延迟求值：解释器的行为类似下面的代码，当定义的新变量并不直接求值，而是在需要时再求值。

(display

(let ((a 1))
    (define (f x)
        (let ((b '*unassigned*)
              (a '*unassigned*))
            (set! b (delay (+ (force a) x)))
            (set! a (delay 5))
            (+ (force a) (force b))))
    (f 10))

)
