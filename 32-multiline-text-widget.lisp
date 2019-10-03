;; 32 シンプルな複数行のテキストウィジェット

(defpackage #:cl-gtk3-tutorial/32-multiline-text-widget
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/32-multiline-text-widget)

(defun main ()
  (gtk:within-main-loop
    (let* ((window (make-instance 'gtk:gtk-window
                                  :type :toplevel
                                  :title "Simple Text View"
                                  :default-width 300))
           (view   (make-instance 'gtk:gtk-text-view))
           (buffer (gtk:gtk-text-view-buffer view)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      (gtk:gtk-text-buffer-insert buffer "Hello, world!")
      (gtk:gtk-container-add window view)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
