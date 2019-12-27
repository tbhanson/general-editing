#lang racket

; compute and return a function which transforms str1 into str2
; first correct, then elegant, then fast enough

(require "levenshtein.rkt")

(define cache (make-hash))

(define (diff-ed-lists lis1 lis2)
  ;(printf "(diff-ed-lists ~a ~a)~n" lis1 lis2)
  (let ([key (cons lis1 lis2)])
    (if (hash-has-key? cache key)
        (hash-ref cache key)
        (let ([result
               (cond [(equal? (length lis1) 0) (lambda (x)
                                                 (begin
                                                   ;(printf "return lis2: ~a~n" lis2)
                                                   lis2))]
                     [(equal? (length lis2) 0) (lambda (x)
                                                 (begin
                                                   ;(printf "empty~n")
                                                   '()))]
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
                          (let ([n1->n2 (+ cost-n1-n2 (list-levenshtein rest1 rest2))]
                                [lis1->rest2 (+ 1 (list-levenshtein lis1 rest2))]
                                [rest1->lis2 (+ 1 (list-levenshtein rest1 lis2))])
                            (let ([best-score (min n1->n2 lis1->rest2 rest1->lis2)])
                              (cond [(= best-score n1->n2) (lambda (x)
                                                             (begin
                                                               ;(printf "cons ~a d r1 r2~n" n2)
                                                               (cons n2 ((diff-ed-lists rest1 rest2) x))))]
                                    [(= best-score lis1->rest2)
                                     (begin
                                       ;(printf "d l1 r2~n")
                                       (diff-ed-lists lis1 rest2))]
                                    [(= best-score rest1->lis2)
                                     (begin
                                       ;(printf "d r1 l2~n")
                                       (diff-ed-lists rest1 lis2))])))))])])
              
          (begin
            (hash-set! cache key result)
            result)))))

(define (difference-editor str1 str2)
  (compose
   list->string
   (diff-ed-lists (string->list str1) (string->list str2))
   string->list))

  
(provide
 diff-ed-lists
 difference-editor)
