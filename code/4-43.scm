(include "4.3.2-common.scm")

(define all-fathers (list 'Moore 'Downing 'Hall 'Barnacle 'Parker))
(define all-daughters (list 'Mary 'Gabrelle 'Lorna 'Rosalind 'Melissa))

;; copied from http://community.schemewiki.org/?sicp-ex-4.43

;; BOATS:
;;  Moore       -   Lorna
;;  Barnacle    -   Gabrielle
;;  Hall        -   Rosalind
;;  Downing     -   Melissa
;;  Parker      -   Mary

(define (father-daughter)
    (let ((Moore 'Mary)
          (Barnacle 'Melissa)
          (Hall (amb 'Gabrelle 'Lorna))
          (Downing (amb 'Gabrelle 'Lorna 'Rosalind))
          (Parker (amb 'Lorna 'Rosalind))) 
                ; └> The name of Gabrielle's Father's Boat is Parker's daughter's name,
                ; so Parker's daughter won't be Gabrielle.
        (require
            ; The name of Gabrielle's Father's Boat is Parker's daughter's name
            (cond
                ((eq? Hall 'Gabrelle) (eq? 'Rosalind Parker))   ;Hall's boat's name is Rosalind
                ((eq? Downing 'Gabrelle) (eq? 'Melissa Parker)) ;Downing's boat's name is Melissa
                (else false)))
        (require (distinct? (list Moore Barnacle Hall Downing Parker)))
        (list
            (list 'Barnacle Barnacle)
            (list 'Moore Moore)
            (list 'Hall Hall)
            (list 'Downing Downing)
            (list 'Parker Parker))))

(father-daughter)

;; ANSWER:
;;  (Moore Mary) (Barnacle Melissa) (Hall Gabrelle) (Downing Lorna) (Parker Rosalind)

;; 如果不知道Moore的女儿是Mary, 会多一个答案
;;  (Moore Gabrelle) (Barnacle Melissa) (Hall Mary) (Downing Rosalind) (Parker Lorna)

(define (father-daughter)
    (let ((Moore (amb 'Mary 'Gabrelle 'Rosalind ))
          (Barnacle 'Melissa)
          (Hall (amb 'Gabrelle 'Lorna))
          (Downing (amb 'Gabrelle 'Lorna 'Rosalind))
          (Parker (amb 'Lorna 'Rosalind))) 
                ; └> The name of Gabrielle's Father's Boat is Parker's daughter's name,
                ; so Parker's daughter won't be Gabrielle.
        (require
            ; The name of Gabrielle's Father's Boat is Parker's daughter's name
            (cond
                ((eq? Moore 'Gabrelle) (eq? 'Lorna Parker))     ;Moore's boat's name is Lorna
                ((eq? Hall 'Gabrelle) (eq? 'Rosalind Parker))   ;Hall's boat's name is Rosalind
                ((eq? Downing 'Gabrelle) (eq? 'Melissa Parker)) ;Downing's boat's name is Melissa
                (else false)))
        (require (distinct? (list Moore Barnacle Hall Downing Parker)))
        (list
            (list 'Barnacle Barnacle)
            (list 'Moore Moore)
            (list 'Hall Hall)
            (list 'Downing Downing)
            (list 'Parker Parker))))
