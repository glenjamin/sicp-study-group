#lang planet neil/sicp

(#%require rackunit)

;; Exercise 1.12

(define (triangle row)
  (if (= row 0)
      (list 1)
      (next-row (append (list 0)
                        (triangle (dec row))
                        (list 0)))))

(define (next-row above)
  (if (< (length above) 2)
      (list)
      (cons (+ (car above) (cadr above))
            (next-row (cdr above)))))
