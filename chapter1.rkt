#lang planet neil/sicp

(#%require rackunit)

;; Exercise 1.1
(check-eqv? 10 10)
(check-eqv? (+ 5 3 4) 12)
(check-eqv? (- 9 1) 8)
(check-eqv? (/ 6 2) 3)
(check-eqv? (+ (* 2 4) (- 4 6)) 6)

(define a 3)
(check-eqv? a 3)

(define b (+ a 1))
(check-eqv? b 4)

(check-eqv? (+ a b (* a b)) 19)

(check-eqv? (= a b) #f)

(check-eqv?
  (if (and (> b a) (< b (* a b)))
      b
      a)
  4)

(check-eqv?
  (cond ((= a 4) 6)
        ((= b 4) (+ 6 7 a))
        (else 25))
  16)

(check-eqv? (+ 2 (if (> b a) b a)) 6)

(check-eqv?
  (* (cond ((> a b) a)
           ((< a b) b)
           (else -1))
     (+ a 1))
  16)

;; Exercise 1.2

(check-eqv?
  (/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
     (* 3 (- 6 2) (- 2 7)))
  -37/150)

;; Exercise 1.3
(define (square a) (* a a))
(define (sum-squares a b)
  (+ (square a) (square b)))
(define (sum-biggest-2-squares a b c)
  (cond ((and (< a b) (< a c)) (sum-squares b c))
        ((and (< b c) (< b a)) (sum-squares c a))
        ((and (< c b) (< c a)) (sum-squares b a))))

(check-eq? (sum-biggest-2-squares 3 4 5) (+ 16 25))
(check-eq? (sum-biggest-2-squares 4 5 3) (+ 16 25))
(check-eq? (sum-biggest-2-squares 3 5 4) (+ 16 25))
(check-eq? (sum-biggest-2-squares 5 3 4) (+ 16 25))

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

(check-false (close-enough? (square (sqrt1 1e-16)) 1e-16 1e-5)
             "Expected sqrt1 to be rubbish with small value")

(define (sqrt-iter2 guess last-guess x)
  (if (converged-enough? guess last-guess)
      guess
      (sqrt-iter2 (improve guess x) guess x)))
(define (converged-enough? guess last-guess)
  (close-enough? (/ guess last-guess) 1 1e-5))
(define (sqrt2 x)
  (sqrt-iter2 1.0 0.0 x))

(check-= (square (sqrt2 1e-16)) 1e-16 1e-5
         "Expected sqrt2 to not be rubbish with small value")

(define (cube-root-iter guess last-guess x)
  (if (converged-enough? guess last-guess)
      guess
      (cube-root-iter (cube-root-improve guess x) guess x)))
(define (cube-root-improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess))
     3.0))
(define (cube-root x)
  (cube-root-iter 1.0 0.0 x))

(check-= (cube-root 27) 3 1e-5)
(check-= (cube-root 64) 4 1e-5)
