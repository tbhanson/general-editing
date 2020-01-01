#lang racket

(require rackunit "first-difference.rkt")

; two empty lists have
; equal length
; last comparison is undefined
; last index is undefined
(check-equal?
 (compare-lists
  (bytes )
  (bytes ))
 (list #t 0 #t -1))

(check-equal?
 (compare-lists
  (bytes 0)
  (bytes 0))
 (list #t 1 #t 0))


(check-equal?
 (compare-lists
  (bytes 1)
  (bytes 0))
 (list #t 1 #f 0))

(check-equal?
 (compare-lists
  (bytes 0 1)
  (bytes 0))
 (list #f 1 #t 0))

(check-equal?
 (compare-lists
  (bytes 0 1)
  (bytes 0 2))
 (list #t 2 #f 1))

(check-equal?
 (compare-lists
  (bytes 0 1 2)
  (bytes 0 2 3))
 (list #t 3 #f 1))

; -------
(check-equal?
 (compare-list-commonality
  (bytes )
  (bytes ))
 (list #t 0 0 0))

(check-equal?
 (compare-list-commonality
  (bytes 0)
  (bytes 0))
 (list #t 1 1 0))


(check-equal?
 (compare-list-commonality
  (bytes 1)
  (bytes 0))
 (list #t 1 0 1))

(check-equal?
 (compare-list-commonality
  (bytes 0 1)
  (bytes 0))
 (list #f 1 1 0))

(check-equal?
 (compare-list-commonality
  (bytes 0 1)
  (bytes 0 2))
 (list #t 2 1 1))

(check-equal?
 (compare-list-commonality
  (bytes 0 1 2)
  (bytes 0 2 3))
 (list #t 3 1 2))