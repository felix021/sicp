#lang racket

(define (make-withdraw initial-amount)
    (lambda (balance)
        (lambda (amount)
            (if (>= balance amount)
                (begin
                    (set! balance (- balance amount))
                    balance)
                "Insufficient funds"))
        initial-amount))

;
;  +------------------------------------------------------------+
;  |  全局环境                                                  |  
;  |                                                            |
;  |                                                            |
;  | make-withdraw+                                             |
;  +--------------|---------------------------------------------+
;                 ↓ ↑                                               
;              [+] [+]                                               
;               ↓                                                    
;          [ arg: balance ]                                                       
;          [ body: ...    ]                                           
;               ↓   ↑                                               
;              [+] [+]                                               
;               ↓                                                   
;          [ arg: amount ]                                                       
;          [ body: ...   ]                                           
;                                                                   
