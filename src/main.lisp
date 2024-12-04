(defpackage #:aoc24
  (:use :cl)
  (:local-nicknames (#:u :uiop))
  (:import-from :uiop #:run-program #:directory-files #:subdirectories)
  (:import-from :aoc24/downloads #:download-input))
(in-package #:aoc24)

;; don't know why we need it
(download-input "1")
(download-input "2")
(download-input "3")
