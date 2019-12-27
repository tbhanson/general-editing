#lang racket

(require rackunit "levenshtein.rkt")

; simplest cases
(check-equal?
 (levenshtein "" "")
 0)

(check-equal?
 (levenshtein "" "a")
 1)

(check-equal?
 (levenshtein "a" "")
 1)

(check-equal?
 (levenshtein "a" "a")
 0)

(check-equal?
 (levenshtein "a" "a")
 0)

(check-equal?
 (levenshtein "a" "b")
 1)

; 2 tests suggested here: https://rosettacode.org/wiki/Levenshtein_distance

(check-equal?
 (levenshtein "kitten" "sitting")
 3)

; (this one took unbearably long with the naive implementation)
(check-equal?
 (levenshtein "rosettacode" "raisethysword")
 8)

; a couple others to help think about caching

(check-equal?
 (levenshtein "siting" "sitting")
 1)

(check-equal?
 (levenshtein "singing" "sitting")
 2)


(check-equal?
 (list-levenshtein (string->list "kitten") (string->list "sitting"))
 3)

; (this one took unbearably long with the naive implementation)
(check-equal?
 (list-levenshtein (string->list "rosettacode") (string->list "raisethysword"))
 8)
