(defpackage #:aoc24
  (:use :cl)
  (:local-nicknames (#:u :uiop))
  (:import-from :uiop #:run-program #:directory-files #:subdirectories)
  (:import-from :aoc24/downloads #:get-input))
(in-package #:aoc24)

(let ((session (u:read-file-line "session.txt")))
  (setq *session-cookie* session)
  (format t (get-input 1)))
