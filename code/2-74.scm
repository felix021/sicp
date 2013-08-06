#lang racket

(require "getput.scm")

(define (get-record company file name)
    ((get company 'get-record) file name))

(define (install-sub-company-A)
    ; file: '((id name salary) ...)
    (define (get-record file name)
        (cond
            ((null? file) #f)
            ((equal? (cadr (car file)) name) (car file))
            (else (get-record (cdr file) name))))
    (define (record-obj record)
        (define (dispatch key)
            (cond
                ((eq? key 'all) record)
                ((eq? key 'id) (car record))
                ((eq? key 'name) (cadr record))
                ((eq? key 'salary) (caddr record))
                (else (error "unknown key: " key))))
        (if record dispatch #f))
    (put 'A 'get-record 
        (lambda (file name) (record-obj (get-record file name))))
    'done)

(define (install-sub-company-B)
    ; file: '((name salary) ...)
    (define (get-record file name)
        (cond
            ((null? file) #f)
            ((equal? (car (car file)) name) (car file))
            (else (get-record (cdr file) name))))
    (define (record-obj record)
        (define (dispatch key)
            (cond
                ((eq? key 'all) record)
                ((eq? key 'name) (car record))
                ((eq? key 'salary) (cadr record))
                (else (error "unknown key: " key))))
        (if record dispatch #f))
    (put 'B 'get-record
        (lambda (file name) (record-obj (get-record file name))))
    'done)

(install-sub-company-A)
(install-sub-company-B)

(define Afile '((1 felix 100) (2 sandy 110)))
(define Bfile '((felix 100) (sandy 110) (boluor 130)))

(get-record 'A Afile 'boluor)
((get-record 'A Afile 'sandy) 'salary)
((get-record 'A Afile 'sandy) 'all)

((get-record 'B Bfile 'boluor) 'all)
((get-record 'B Bfile 'sandy) 'salary)
((get-record 'B Bfile 'sandy) 'all)

;; c) files: (('A Afile) ('B Bfile) ...)
(define (find-employ-record name files)
    (if (null? files)
        #f
        (letrec
            ((curr (car files))
             (company (car curr))
             (file (cadr curr))
             (ans (get-record company file name)))
            (if ans
                ans
                (find-employ-record name (cdr files))))))

(newline)

((find-employ-record 'sandy (list (list 'A Afile) (list 'B Bfile))) 'all)
((find-employ-record 'boluor (list (list 'A Afile) (list 'B Bfile))) 'all)
(find-employ-record 'wtq (list (list 'A Afile) (list 'B Bfile)))

;; D) add installer, with implemented get-record and record-obj
