; 正文的版本可以正常工作，题中的版本不行：
;
; y: *unassigned*
; dy: *unassigned*
; a: (integral (delay dy) y0 dt)
;
; 此时 dy = *unassigned* , 解释器会报错。
