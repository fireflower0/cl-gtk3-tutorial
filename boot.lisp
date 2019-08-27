(defpackage #:cl-gtk3-tutorial
  (:use #:cl)
  (:import-from #:cl-gtk3-tutorial/01-simple-window)
  (:export #:start))
(in-package #:cl-gtk3-tutorial)

(defun start (&key id)
  (case id
    (1 (cl-gtk3-tutorial/01-simple-window:main))
    (t (format t "Hello, GTK3~%"))))
