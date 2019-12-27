#lang racket

(require rackunit "difference-editor.rkt")

; simplest cases
(check-equal?
 ((difference-editor "" "") "")
 "")

(check-equal?
 ((difference-editor "" "a") "")
 "a")

(check-equal?
 ((difference-editor "a" "") "a")
 "")

(check-equal?
 ((difference-editor "a" "ab") "a")
 "ab")

(check-equal?
 ((difference-editor "ab" "xy") "ab")
 "xy")

(check-equal?
 ((difference-editor "sitting" "kitten") "sitting")
 "kitten")


