;;   (or a b)
;; = (not (and (not a) (not b)))
;;
;;  --a-- NOT --c--
;;                  \
;;                  AND --e-- OR --output--
;;                  /
;;  --b-- NOT --d--
;;
(define (or-gate a b output)
    (let ((c (make-wire))
          (d (make-wire))
          (e (make-wire)))
          (inverter a c)
          (inverter b d)
          (and-gate c d e)
          (inverter e output)))
