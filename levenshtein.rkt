#lang racket

; a naive initial implementation, seemingly correct, but noticeably slow for relatively small cases

(define (levenshtein str1 str2)
  (define (lev-lists lis1 lis2)
    (cond ((equal? (length lis1) 0) (length lis2))
          ((equal? (length lis2) 0) (length lis1))
          (else
           ; now compute the smallest of the alternatives reducing at least one list by one character
           (let ([n1 (first lis1)]
                 [n2 (first lis2)]
                 [rest1 (rest lis1)]
                 [rest2 (rest lis2)])
             (let ([cost-n1-n2
                    (if (equal? n1 n2)
                        0
                        1)])
                 (min (+ cost-n1-n2 (lev-lists rest1 rest2))
                      (+ 1 (lev-lists lis1 rest2))
                      (+ 1 (lev-lists lis2 rest1))))))))

  (lev-lists (string->list str1) (string->list str2)))

(provide levenshtein)
