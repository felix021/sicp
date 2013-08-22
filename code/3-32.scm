; Queue(FIFO):
;
;  [front]-> ((set-signal! A 0) (set-signal! B 1) (set-signal! A 1) (set-signal! B 0))
;
;  从front开始执行，最终A、B的状态是 1, 0
;
;
; Stack(FILO):
;
;  [front]-> ((set-signal! B 0) (set-signal! A 1) (set-signal! B 1) (set-signal! A 0))
;
;  从front开始执行，最终A、B的状态是 0, 1 不符合预期。
;
