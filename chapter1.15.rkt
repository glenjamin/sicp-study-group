#lang planet neil/sicp

(#%require rackunit)

;; Exercise 1.15
(define (cube x) (* x x x))
(define (p x)
  (set! calls (inc calls))
  (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
   (if (not (> (abs angle) 0.1))
       angle
       (p (sine (/ angle 3.0)))))

(define calls 0)
(define (count-p angle)
  (set! calls 0)
  (sine angle)
  calls)

; a
(sine 12.15)
(count-p 12.15) ; => 6

; b
; punted on this one too
; turned out to be fairly clearly log3(a)
