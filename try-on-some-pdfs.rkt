#lang racket

(require "first-difference.rkt")

(define default-base-path
  (build-path (find-system-path 'home-dir)
              "Dropbox/taxesRetirementEtc/taxes"
              "testing or in progress"
              "2018"))


    
(define base-seconds (current-seconds))

(define (seconds-since)
  (- (current-seconds) base-seconds))
  

(let ([pdf1-bytes
       (port->bytes (open-input-file (build-path default-base-path "f1116--2018_saved_with_Preview.pdf")))]
      [pdf2-bytes
       (port->bytes (open-input-file (build-path default-base-path "f1116--2018_with_Name.pdf")))])
  (let ([first-diff (compare-lists pdf1-bytes pdf2-bytes)]
        [diff-stats (compare-list-commonality pdf1-bytes pdf2-bytes)])
    (printf " (compare-lists pdf1-bytes pdf2-bytes): ~a~n" first-diff)
    (printf " (compare-list-commonality pdf1-bytes pdf2-bytes): ~a~n" diff-stats)
    (let ([idx-first-diff (cadddr first-diff)])
      (printf "range around first differences")
      (show-range-two-lists pdf1-bytes pdf2-bytes (- idx-first-diff 10) (+ idx-first-diff 25)))))
    
  
(printf "~n- - ~a - -~n" (seconds-since))


