; a) 
;     +--> [base-env]
;     |
;     |
; [new env](u '*unassigned*) (v '*unassigned*)
;       (set! u <e1>)
;       (set! u <e2>)
;       <e3>
;
; 因为使用了let，会被翻译成lambda，导致到一层框架
;
; b)
; 把所有的define都提到前面来
