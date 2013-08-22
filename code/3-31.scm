; 先说对应的现实意义：当你将两个点连接起来的时候，应该马上会起作用。
; 再说这个程序，其实这跟set-my-signal!的实现也有关系，注意它加了一个if:

        (define (set-my-signal! new-value)
            (if (not (= signal-value new-value))
                (begin
                    (set! signal-value new-value)
                    (call-each action-procedures))
                'done))

; 也就是说，如果后续设置的信号与当前信号相同的话不会有任何改变。
;
; 加入把accept-action-procedure!里的(proc)去掉，那么信号的初始状态不
; 会反映到现在的电路中。于是就引出问题了：由于(make-wire)的时候设置的
; 是默认值 0 ，那么后续给它的值还是0的话，这个电路就不会有任何变化，
; 这不符合电路的工作预期，导致了错误的结果。
;
; 当然，如果一定要把(proc)去掉也没可以，我们可以认为初始状态下信号的值是
; 没有意义的，但是需要 set-my-signal! 里面的判断条件去掉，无条件执行
; (call-each action-procedures)，这样再设置信号的时候就会得到预期的反应。
;
