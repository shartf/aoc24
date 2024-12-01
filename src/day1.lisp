(defpackage #:aoc24/day1
  (:use :cl)
  (:local-nicknames (#:u :uiop)
		    (#:s :serapeum))
  (:import-from :uiop #:run-program #:directory-files #:subdirectories)
  (:export #:download-input))
(in-package #:aoc24/day1)

;;read in, parse to integers and push into vectors

(defparameter *parsed-input-one* (make-array 1000 :fill-pointer 0 :element-type 'integer))
(defparameter *parsed-input-two* (make-array 1000 :fill-pointer 0 :element-type 'integer))
(defparameter *test-input-one* (vector 3 4 2 1 3 3))
(defparameter *test-input-two* (vector 4 3 5 3 9 3))

(let ((in (open (asdf:system-relative-pathname "aoc24" "input/1.txt")  :if-does-not-exist nil)))
  (when in
    (loop for line = (read-line in nil)
	  while line do
	    ;;(format t "~a~%" line)
	    (let ((words (s:words line)))
	      ;;(format t "~&this is line: ~S" line)
	      ;;(format t "~&first: ~S, second:~S" (parse-integer (first words)) (parse-integer (second words)))
	      (vector-push (parse-integer (first words)) *parsed-input-one*)
	      (vector-push (parse-integer (second words)) *parsed-input-two*)))
    (close in)))

;; PART 1

(defun solve-part-one ()

  ;; sort (destructive)ns
  (sort *parsed-input-one* '<)
  (sort *parsed-input-two* '<)
  ;;(sort *test-input-one* '<)
  ;;(sort *test-input-two* '<)

  ;; find distance
  (defun find-distance (a b)
    "Finds numberic distance between two numbers."
    (cond ((< a b) (- b a))
	  ((> a b) (- a b))
	  (t 0)))

  (reduce #'+ (map 'vector (lambda (a b) (find-distance a b)) *parsed-input-one* *parsed-input-two*)))
;;3569916

;; PART 2
(defun get-count (num vec)
  "gets a number of occurences of num in vector."
  (let ((count 0))
    (loop for i across vec do
      (if (= i num)
	  (incf count))
	  finally
	     (return (* count num)))))

(reduce #'+ (loop for a across *parsed-input-one*
		  collect (get-count a *parsed-input-two*)))
;;26407426
