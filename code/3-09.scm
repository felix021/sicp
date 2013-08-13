#lang racket

(define (factorial n)
    (if (= n 1)
        1
        (* n (factorial (- n 1)))))

;  +------------------------------------------------------------+
;  |  全局环境  factorial: [code]                               |  
;  +------------------------------------------------------------+
;     ↑         ↑         ↑         ↑         ↑         ↑ 
;   +-----+   +-----+   +-----+   +-----+   +-----+   +-----+  
;   | n:6 | → | n:5 | → | n:4 | → | n:3 | → | n:2 | → | n:1 |   
;   +-----+   +-----+   +-----+   +-----+   +-----+   +-----+ 

(define (fact-iter product counter max-count)
    (if (> counter max-count)
        product
        (fact-iter (* counter product)
                   (+ counter 1)
                   max-count)))

(define (factorial-iter n)
    (fact-iter 1 1 n)

;  +---------------------------------------------------------------------------------+
;  |  全局环境  factorial-iter: [code]                                               |  
;  |            fact-iter: [code]                                                    |
;  +---------------------------------------------------------------------------------+
;     ↑         ↑                 ↑                 ↑                   ↑              
;   +-----+   +-------------+   +-------------+   +-------------+     +-------------+  
;   |     |   | product:1   |   | product:1   |   | product:2   |     | product:720 |  
;   | n:6 | → | counter:1   | → | counter:2   | → | counter:3   |     | counter:7   |  
;   |     |   | max-count:6 |   | max-count:6 |   | max-count:6 | ... | max-count:6 |  
;   +-----+   +-------------+   +-------------+   +-------------+     +-------------+  
;      ↑        fact-iter         fact-iter         fact-iter           fact-iter     
;   factorial-iter
