(defpackage #:aoc24
  (:use :cl)
  (:local-nicknames (#:u :uiop))
  (:import-from :uiop #:run-program #:directory-files #:subdirectories)
  (:import-from :aoc24/downloads #:download-input))
(in-package #:aoc24)


(download-input "3")
