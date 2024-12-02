(defpackage #:aoc24/day2
  (:use :cl)
  (:local-nicknames (#:u :uiop)
		    (#:s :serapeum))
  (:import-from :uiop #:run-program #:directory-files #:subdirectories)
  (:export #:download-input))
(in-package #:aoc24/day2)

(defparameter *test-first* '('(7 6 4 2 1)
			     '(1 2 7 8 9)
			     '(9 7 6 2 1)
			     '(1 3 2 4 5)
			     '(8 6 4 4 1)
			     '(1 3 6 7 9)))
(defparameter *res-inc-dec* '())
(defparameter *res-interval* '())

(let ((in (open (asdf:system-relative-pathname "aoc24" "input/2.txt")  :if-does-not-exist nil)))
  (when in
    (loop for line = (read-line in nil)
	  while line do
	    ;;(format t "~a~%" (type-of (s:words line)))
	    (push (inc-dec-val (mapcar #'parse-integer (s:words line))) *res-inc-dec*)
	    (push (interval-validator (mapcar #'parse-integer (s:words line))) *res-interval*))
    (close in)))



(defun inc-dec-val (report)
  "Check for increasing and decresing levels."
  (cond ((> (second report) (first report))
	 (inc-checker report))
	((< (second report) (first report))
	 (dec-checker report))
	(t
	 nil)))

(defun inc-checker (report)
  "Returns t if constantly increasong, nil of not."
  (cond ((null (second report) ) t)
	((or  (< (second report) (first report))
	      (= (second report) (first report))) nil)
	(t (inc-checker (rest report)))))

(defun dec-checker (report)
  "Returns t if consantly decreasing, nil if not."
  (cond ((null (second report)) t)
	((or (> (second report) (first report))
	     (= (second report) (first report))) nil)
	(t (dec-checker (rest report)))))

(defun mod-checker (report)
  "Generates a sequence of absolute distances."
  (cond ((null (second report)) nil)
	(t (cons (abs (- (first report) (second report)))
		 (mod-checker (rest report))))))

(defun interval-validator (report)
  "Check that the interval is <4"
  (every (lambda (x) (< x 4)) (mod-checker report)))


;; we do it even twice, with a loop and mapcar
(defun true-count (lst)
  "Counts true for true!"
  (let ((count 0))
    (loop for i in lst do
      (if (not (null i))
	  (incf count))
	  finally (return count))))

(reduce #'+ (mapcar #'(lambda (x y)
			(if (and x y) 1 0)) *res-inc-dec* *res-interval*))
;; -> 246
