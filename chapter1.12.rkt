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

(check-equal? (triangle 0) '(1))
(check-equal? (triangle 1) '(1 1))
(check-equal? (triangle 2) '(1 2 1))
(check-equal? (triangle 3) '(1 3 3 1))
(check-equal? (triangle 4) '(1 4 6 4 1))

(define (triangle2 row n)
  (cond
    ((and (= row 0) (= n 0)) 1)
    ((> row 0) (+ (triangle2 (dec row) (dec n))
                  (triangle2 (dec row) n)))
    (else 0)))

(check-equal? (triangle2 0 0) 1)
(check-equal? (triangle2 1 0) 1)
(check-equal? (triangle2 1 1) 1)
(check-equal? (triangle2 2 0) 1)
(check-equal? (triangle2 2 1) 2)
(check-equal? (triangle2 2 2) 1)
(check-equal? (triangle2 3 0) 1)
(check-equal? (triangle2 3 1) 3)
(check-equal? (triangle2 3 2) 3)
(check-equal? (triangle2 3 3) 1)
