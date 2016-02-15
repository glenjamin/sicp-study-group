#lang planet neil/sicp

;; Exercise 1.1
10
; 10
(+ 5 3 4)
; 12
(- 9 1)
; 8
(/ 6 2)
; 3
(+ (* 2 4) (- 4 6))
; 6
(define a 3)
; 3
(define b (+ a 1))
; 4
(+ a b (* a b))
; 19
(= a b)
; #f
(if (and (> b a) (< b (* a b)))
    b
    a)
; 4
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
; 16
(+ 2 (if (> b a) b a))
; 6
(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))
; 16

;; Exercise 1.2

(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
   (* 3 (- 6 2) (- 2 7)))

;; Exercise 1.3
(define (square a) (* a a))
(define (sum-squares a b)
  (+ (square a) (square b)))
(define (sum-biggest-2-squares a b c)
  (cond ((and (< a b) (< a c)) (sum-squares b c))
        ((and (< b c) (< b a)) (sum-squares c a))
        ((and (< c b) (< c a)) (sum-squares b a))))

;; Exercise 1.4

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
; Uses the sign of b to select either the + or - function

;; Exercise 1.5

(define (p) (p))
(define (test x y)
  (if (= x 0)
      0
      y))

; (test 0 (p))
; applicative order will infinite loop trying to expand (p) first
; normal order will halt with 0 before considering expansion of (p)

;; Exercise 1.6

; The else branch will always be evaluated, and thus the recursion never
; terminates

;; Exercise 1.7
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))
(define (improve guess x)
  (average guess (/ x guess)))
(define (average a b)
  (/ (+ a b) 2))
(define (good-enough? guess x)
  (close-enough? (square guess) x 0.001))
(define (close-enough? a b accuracy)
  (< (abs (- a b)) accuracy))
(define (sqrt1 x)
  (sqrt-iter 1.0 x))

(define (sqrt-accuracy f x)
  (- x (square (f x))))

; sample bad case:
;  (sqrt1 1e-16) => 0.03125000000000106
;  (square 0.03125000000000106) => 0.0009765625000000664

(define (sqrt-iter2 guess last-guess x)
  (if (converged-enough? guess last-guess)
      guess
      (sqrt-iter2 (improve guess x) guess x)))
(define (converged-enough? guess last-guess)
  (close-enough? (/ guess last-guess) 1 0.001))
(define (sqrt2 x)
  (sqrt-iter2 1.0 0.0 x))

; with sqrt2
; (sqrt2 1e-16) => 1.0000000009432505e-08

(define (cube-root-iter guess last-guess x)
  (if (converged-enough? guess last-guess)
      guess
      (cube-root-iter (cube-root-improve guess x) guess x)))
(define (cube-root-improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess))
     3.0))
(define (cube-root x)
  (cube-root-iter 1.0 0.0 x))
