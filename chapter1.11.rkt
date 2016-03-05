#lang planet neil/sicp

(#%require rackunit)

;; Exercise 1.11
(define (f n)
  (cond ((< n 3) n)
        (else (+ (f (- n 1))
                 (* 2 (f (- n 2)))
                 (* 3 (f (- n 3)))))))

(check-eq? (f 0) 0)
(check-eq? (f 1) 1)
(check-eq? (f 2) 2)

(define (f2 n)
  (define (f2-iter a b c count)
    (if (= count 0)
        c
        (f2-iter (+ a (* 2 b) (* 3 c)) a b (dec count))))
  (f2-iter 2 1 0 n))

(check-eq? (f 0) (f2 0))
(check-eq? (f 1) (f2 1))
(check-eq? (f 2) (f2 2))
(check-eq? (f 3) (f2 3))
(check-eq? (f 4) (f2 4))
(check-eq? (f 5) (f2 5))
(check-eq? (f 6) (f2 6))
(check-eq? (f 6) (f2 6))
(check-eq? (f 7) (f2 7))
