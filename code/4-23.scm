; 正文：
#|

(analyze-sequence '((foo))) =>
    (define procs (map analyze exps)) =>
        procs:
            (list (analyze '(foo)))
        (loop (car procs) (cdr procs)) =>
            first-proc: [(analyze '(foo))]
            rest-procs: '()
            ;返回: first-proc

(analyze-sequence '((foo) (bar))) =>
    (define procs (map analyze exps)) =>
        procs:
            (list (analyze '(foo)) (analyze '(bar)))
            (list analyzed-foo analyzed-bar)
        (loop (car procs) (cdr procs)) =>
            (loop
                (lambda (env) (analyzed-foo env) (analyzed-bar env))
                '())
            ;返回: (lambda (env) (analyzed-foo env) (analyzed-bar env))
                

|#

; Alyssa:
#|

(analyze-sequence '((foo))) =>
    (define procs (map analyze exps)) =>
        procs:
            (list (analyze '(foo)))
        ;返回: (lambda (env) (execute-sequence procs env))

(analyze-sequence '((foo) (bar))) =>
    (define procs (map analyze exps)) =>
        procs:
            (list (analyze '(foo)) (analyze '(bar)))
        ;返回: (lambda (env) (execute-sequence procs env))
|#
    

