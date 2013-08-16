(load "3.3.2-queue.scm")

(define q1 (make-queue))

(insert-queue! q1 'a)
(display q1) (newline)

; q1 = (head, tail)
; (display head) 会一直输出到队列末尾

(insert-queue! q1 'b)
(display q1) (newline)

(print-queue q1)

(delete-queue! q1)
(display q1) (newline)

(delete-queue! q1)
(display q1) (newline)
