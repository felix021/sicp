(include "4.3.2-common.scm")

(define (true-false a b)
    (or
        (and a (not b))
        (and (not a) b)))

;; amb version
#| 
(define (require-a-b a b)
    (require (true-false a b)))

(define (liar)
    (let ((betty (an-integer-between 1 5))
          (ethel (an-integer-between 1 5))
          (joan (an-integer-between 1 5))
          (kitty (an-integer-between 1 5))
          (mary (an-integer-between 1 5)))
        (require-a-b (= kitty 2) (= betty 3))
        (require-a-b (= ethel 1) (= joan 2))
        (require-a-b (= joan 3)  (= ethel 5))
        (require-a-b (= kitty 2) (= mary 4))
        (require-a-b (= mary 4)  (= betty 1))
        (let ((try (list 'betty ethel joan kitty mary)))
            (require (distinct? try))
            try)))
|#

;; normal version
(define (liar)
    (for-each
        (lambda (try)
            (apply
                (lambda (betty ethel joan kitty mary)
                    (if (and
                            (true-false (= kitty 2) (= betty 3))
                            (true-false (= ethel 1) (= joan 2))
                            (true-false (= joan 3)  (= ethel 5))
                            (true-false (= kitty 2) (= mary 4))
                            (true-false (= mary 4)  (= betty 1)))
                        (display try)))
                try))
        (permutations '(1 2 3 4 5))))

(liar)
