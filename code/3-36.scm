(load "3.3.5.scm")

(define a (make-connector))
(define b (make-connector))

(set-value! a 10 'user)


; (for-each-except setter inform-about-value constraints)
#|
(set-value! a 10 'user)
 -> ((a 'set-value!) 10 'user) => [set-value!: connector=a new-value=10 informant='user] => [GLOBAL]
     -> (set-my-value new-value informant) [make-connector: value=false informant=false constraints=()] => [GLOBAL]
         -> (not (has-value? me)) [set-my-value: newval=10 setter=user] => make-connector
                (set! value newval)
                (set! informant setter)
                (for-each-except setter inform-about-value constraints)
|#
