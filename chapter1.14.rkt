#lang planet neil/sicp

(#%require rackunit)

(define calls 0)

;; Exercise 1.14
(define (count-change amount)
  (set! calls 0)
  (cc amount 5))
(define (cc amount kinds-of-coins)
  (set! calls (inc calls))
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))


(lambda x
  (count-change 11)
  (cc 11 5)
  (+ (cc 11 4)
     (cc (- 11 50) 5))
  (cc 11 4)
  (+ (cc 11 3)
     (cc (- 11 25) 4))
  (cc 11 3)
  (+ (cc 11 2)
     (cc (- 11 10) 3))
  (+ (cc 11 2)
     (cc 1 3))
  (+ (+ (cc 11 1)
        (cc (- 11 5) 2))
     (+ (cc 1 2)
        (cc (- 1 10) 3)))
  (+ (+ (cc 11 1)
        (cc 6 2))
     (+ (cc 1 2)))
  (+ (+ (+ (cc 11 0) (cc (- 11 1) 1))
        (+ (cc 6 1) (cc (- 6 5) 2)))
     (+ (cc 1 1) (cc (- 1 5) 2)))

  (+ (cc 10 1)
     (cc 6 1)
     (cc 1 2)
     (cc 1 1))
  )

(lambda x
  "commented out, it's slow"
  (display
    (map
      (lambda (x)
        (count-change x)
        (list x calls))
      '(10 50 100 300 500 1000)))

  ((10 41) (50 1571) (100 15499) (300 1292591)
   (500 12822611) (1000 333082021)))

; I'm not really any wiser from this brute force analysis
;
; googling tells me it's fairly tricky
; space is O(a) a = amount
; time is O(a^n) n = number of coins
