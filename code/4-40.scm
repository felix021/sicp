;; The use of 'an-integer-between' helps a lot here.

(define (multiple-dwelling)
    (let* ((baker (amb 1 2 3 4))
          (cooper (amb 2 3 4 5))
          (fletcher (amb 2 3 4)))
        (require (not (= (abs (- fletcher cooper)) 1)))
        (let* ((miller (an-integer-between (+ 1 cooper) 5))
               (smith (amb
                        (an-integer-between (1 (- fletcher 2)))
                        (an-integer-between (+ fletcher 2) 5))))
            (require
                (distinct? (list baker cooper fletcher miller smith)))
            (list
                (list 'baker baker)
                (list 'cooper cooper)
                (list 'fletcher fletcher)
                (list 'miller miller)
                (list 'smith smith)))))

