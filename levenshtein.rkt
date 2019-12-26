#lang racket

; added result-caching to the naive initial implementation, which improves speed considerably

(define (levenshtein str1 str2)
  (let ([cache (make-hash)])
    (define (lev-lists lis1 lis2)
      (let ([key (cons lis1 lis2)])
        (if (hash-has-key? cache key)
            (hash-ref cache key)
            (let ([result
                   (cond ((equal? (length lis1) 0) (length lis2))
                         ((equal? (length lis2) 0) (length lis1))
                         (else
                          (begin
                            ;(printf "lev-lists ~a ~a~n" lis1 lis2)
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
                                       (min (+ cost-n1-n2 (lev-lists rest1 rest2))
                                            (+ 1 (lev-lists lis1 rest2))
                                            (+ 1 (lev-lists lis2 rest1)))])
                                  (begin
                                    ;(printf "--> ~a~n" min-result)
                                    min-result)))))))])
              (begin
                (hash-set! cache key result)
                result)))))
              

    (lev-lists (string->list str1) (string->list str2))))


(provide levenshtein)
