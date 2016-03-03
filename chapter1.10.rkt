#lang planet neil/sicp

(#%require rackunit)

;; Exercise 1.10
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(lambda x
  (A 1 10)
  (A 0 (A 1 9))
  (A 0 (A 0 (A 1 8)))
  (A 0 (A 0 (A 0 (A 1 7))))
  (A 0 (A 0 (A 0 (A 0 (A 1 6)))))
  (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))
  (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))
  (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))
  (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))
  (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
  (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
  (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))
  (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))
  (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))
  (A 0 (A 0 (A 0 (A 0 (A 0 32)))))
  (A 0 (A 0 (A 0 (A 0 64))))
  (A 0 (A 0 (A 0 128)))
  (A 0 (A 0 256))
  (A 0 512)
  1024
  )

(check-eq? (A 1 10) 1024)

(lambda x
  (A 2 4)
  (A 1 (A 2 3))
  (A 1 (A 1 (A 2 2)))
  (A 1 (A 1 (A 1 (A 2 1))))
  (A 1 (A 1 (A 1 2)))
  (A 1 (A 1 (A 0 (A 1 1))))
  (A 1 (A 1 (A 0 2)))
  (A 1 (A 1 4))
  (A 1 16)
  65536
  )

(check-eq? (A 2 4) 65536)

(lambda x
  (A 3 3)
  (A 2 (A 3 2))
  (A 2 (A 2 (A 3 1)))
  (A 2 (A 2 2))
  (A 2 4)
  65536
  )

(check-eq? (A 3 3) 65536)

; f(n) = 2n
(define (f n) (A 0 n))
(check-eq? (f 5) 10)
(check-eq? (f 10) 20)
(check-eq? (f 30) 60)

; g(n) = 2^n
(define (g n) (A 1 n))
(check-eq? (g 5) 32)
(check-eq? (g 10) 1024)
(check-eq? (g 30) 1073741824)

; h(n) = ??? Can't seem to express this non-iteratively
(define (h n) (A 2 n))
(check-eq? (h 1) 2) ; 2                   2^1
(check-eq? (h 2) 4) ; 2^2                 2^2
(check-eq? (h 3) 16) ; 2^2^2              2^4
(check-eq? (h 4) 65536) ; 2^2^2^2         2^16
(check-eq? (h 5) '??????) ; 2^2^2^2^2     2^65536
