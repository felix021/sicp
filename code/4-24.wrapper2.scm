(define dont-run-all 1)
(include "4.1.7.scm")

(define start (get-internal-real-time))
(driver-loop)
(define end (get-internal-real-time))
(display (/ (- end start) 1000000000.0))
