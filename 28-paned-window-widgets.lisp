;; 28 パンウィンドウウィジェット

(defpackage #:cl-gtk3-tutorial/28-paned-window-widgets
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/28-paned-window-widgets)

(defun main ()
  (gtk:within-main-loop
   (let ((window (make-instance 'gtk:gtk-window
                                :type :toplevel
                                :title "Paned Window"
                                :border-width 12))
         (paned  (make-instance 'gtk:gtk-paned
                                :orientation :vertical))
         (frame1 (make-instance 'gtk:gtk-frame
                                :label "Window 1"))
         (frame2 (make-instance 'gtk:gtk-frame
                                :label "Window 2")))

     ;; destroy シグナルをラムダ関数と結びつける
     (gobject:g-signal-connect window "destroy"
                               (lambda (widget)
                                 (declare (ignore widget))
                                 (gtk:leave-gtk-main)))
     
     (setf (gtk:gtk-widget-size-request window) '(300 250))
     
     (gtk:gtk-container-add window paned)
     
     (gtk:gtk-paned-add1 paned frame1)
     (gtk:gtk-paned-add2 paned frame2)

     ;; ウィジェット表示
     (gtk:gtk-widget-show-all window))))
