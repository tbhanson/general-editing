#lang racket

; compare two lists and return a quadruple:
; - lengths equal?
; - minimum length (common length, maximum compared index)
; - last compared bytes equal?
; - index of last comparison
(define (compare-lists list1 list2)
  (let ([len1 (bytes-length list1)]
        [len2 (bytes-length list2)])
    (let ([maxlen (max len1 len2)]
          [minlen (min len1 len2)])
      (cond [(= minlen 0) (list #t 0 #t -1)]
            [else
             (let ([result
                    (for/last ([b1 list1]
                               [b2 list2]
                               [idx (in-range (+ minlen 1))]
                               #:final (not (= b1 b2)))
                      ;(printf "idx: ~a~n" idx)
                      (list (= b1 b2) idx)
                      )])
               ;(printf "result: ~a~n" result)
               (append (list (= len1 len2) minlen) result))]))))

(define (show-range-two-lists list1 list2 lo-index hi-index)
  (for ([b1 list1]
        [b2 list2]
        [idx (in-range hi-index)]
        #:when (>= idx lo-index))
    (printf "~a: ~a (~a) ~a (~a)~n" idx b1 (integer->char b1) b2 (integer->char b2))))

(provide compare-lists
         show-range-two-lists)
