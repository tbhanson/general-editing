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

; because of the way edits are destructive and don't check their preconditions, this works too:
(check-equal?
 ((difference-editor "ab" "xy") "cd")
 "xy")

