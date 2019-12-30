#lang racket

; added result-caching to the naive initial implementation, which improves speed considerably

(define cache (make-hash))
  
(define (list-levenshtein lis1 lis2)
  (let ([key (cons lis1 lis2)])
    (if (hash-has-key? cache key)
        (hash-ref cache key)
        (let ([result
               (cond [(equal? (length lis1) 0) (length lis2)]
                     [(equal? (length lis2) 0) (length lis1)]
                     [else
                      ; now compute the smallest of the alternatives reducing at least one list by one character
                      (let ([n1 (first lis1)]
                            [n2 (first lis2)]
                            [rest1 (rest lis1)]
                            [rest2 (rest lis2)])
                        (let ([cost-n1-n2
                               (if (equal? n1 n2)
                                   0
                                   1)])
                          (let ([min-result
                                 (min (+ cost-n1-n2 (list-levenshtein rest1 rest2))
                                      (+ 1 (list-levenshtein lis1 rest2))
                                      (+ 1 (list-levenshtein lis2 rest1)))])
                            min-result)))])])
          (begin
            (hash-set! cache key result)
            result)))))
  
(define (levenshtein str1 str2)
  (list-levenshtein (string->list str1) (string->list str2)))

(define (bytes-levenshtein bytes1 bytes2)
  (list-levenshtein (bytes->list bytes1) (bytes->list bytes2)))

(provide list-levenshtein
         bytes-levenshtein
         levenshtein)
