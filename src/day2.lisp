(defpackage #:aoc24/day2
  (:use :cl)
  (:local-nicknames (#:u :uiop)
		    (#:s :serapeum))
  (:import-from :uiop #:run-program #:directory-files #:subdirectories)
  (:export #:download-input))
(in-package #:aoc24/day2)

(defparameter *test-first* '((7 6 4 2 1)
			     (1 2 7 8 9)
			     (9 7 6 2 1)
			     (1 3 2 4 5)
			     (8 6 4 4 1)
			     (1 3 6 7 9)))
(defparameter *res-inc-dec* '())
(defparameter *res-interval* '())
(defparameter *part-two-perm* '())
(defparameter *test-two-perm* '(((7 6 4 2 1) (6 4 2 1) (7 4 2 1) (7 6 2 1) (7 6 4 1) (7 6 4 2))
				((1 2 7 8 9) (2 7 8 9) (1 7 8 9) (1 2 8 9) (1 2 7 9) (1 2 7 8))
				((9 7 6 2 1) (7 6 2 1) (9 6 2 1) (9 7 2 1) (9 7 6 1) (9 7 6 2))
				((1 3 2 4 5) (3 2 4 5) (1 2 4 5) (1 3 4 5) (1 3 2 5) (1 3 2 4))
				((8 6 4 4 1) (6 4 4 1) (8 4 4 1) (8 6 4 1) (8 6 4 1) (8 6 4 4))
				((1 3 6 7 9) (3 6 7 9) (1 6 7 9) (1 3 7 9) (1 3 6 9) (1 3 6 7))))

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


(let ((in (open (asdf:system-relative-pathname "aoc24" "input/2.txt")  :if-does-not-exist nil)))
  (when in
    (loop for line = (read-line in nil)
	  while line do
	    ;;(format t "~a~%" (type-of (s:words line)))
	    (push (inc-dec-val (mapcar #'parse-integer (s:words line))) *res-inc-dec*)
	    (push (interval-validator (mapcar #'parse-integer (s:words line))) *res-interval*))
    (close in)))
(format t "~&Day 2 part 1 solution is: ~s" (reduce #'+ (mapcar #'(lambda (x y)
								   (if (and x y) 1 0)) *res-inc-dec* *res-interval*)))

;; PART 2

;; generate permutated lists
(let ((in (open (asdf:system-relative-pathname "aoc24" "input/2.txt")  :if-does-not-exist nil)))
  (when in
    (loop for line = (read-line in nil)
	  while line do
	    (let ((parsed-line (mapcar #'parse-integer (s:words line))))
	      ;;(format t "~a~%" (type-of (s:words line)))
	      (push (append (list  parsed-line) (lists-with-one-removed parsed-line)) *part-two-perm*)))
    (close in)))

(defun remove-nth-element (lst n)
  "Remove the element at index N from LST."
  (append (subseq lst 0 n) (subseq lst (1+ n))))

(defun lists-with-one-removed (lst)
  "Generate a list of lists where each element from LST is removed once."
  (loop for i from 0 below (length lst)
	collect (remove-nth-element lst i)))

;; TODO: do not forget to parse to int
(defun process-report (list-of-reports)
  "Receives a list of lists of permutated reports and retuns pairs in case any of them is good.
Two T T for a pair indicate a valid result. Any pair of T T for a permutated report makes it valid."
  (let ((res '()))
    (loop for lst in list-of-reports do
					;(format t "~&~s" lst)
      (let* ((inc-del-results (inc-dec-val lst))
	     (val-results (interval-validator lst)))
					;(format t "~&inc-del: ~s, val-res: ~s" inc-del-results val-results)
	(push (list inc-del-results val-results) res)))
    (mapcar #'(lambda (subl) (count t subl)) res)
    ))

(defun validate-report (processed-report)
  "Takes a list of values of processed report (1 2 2 2) where 2 signifies a valid pair.
Returns T if there is at least one 2."
  (some #'(lambda (x) (equal x 2)) processed-report))


(format t "~&Solution for day 2 part 2 is: ~s" (count T (mapcar #'(lambda (subl) (validate-report (process-report subl))) *part-two-perm*)))
