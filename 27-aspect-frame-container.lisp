;; 27 アスペクトフレームコンテナ

(defpackage #:cl-gtk3-tutorial/27-aspect-frame-container
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/27-aspect-frame-container)

(defun main ()
  (gtk:within-main-loop
   (let ((window (make-instance 'gtk:gtk-window
                                :type :toplevel
                                :title "Aspect Frame"
                                :default-width 300
                                :default-height 250
                                :border-width 12))
         (frame  (make-instance 'gtk:gtk-aspect-frame
                                :label "Ratio 2 x 1"
                                :xalign 0.5
                                :yalign 0.5
                                :ratio 2
                                :obey-child nil))
         (area   (make-instance 'gtk:gtk-drawing-area
                                :width-request 200
                                :hight-request 200)))

     ;; destroy シグナルをラムダ関数と結びつける
     (gobject:g-signal-connect window "destroy"
                               (lambda (widget)
                                 (declare (ignore widget))
                                 (gtk:leave-gtk-main)))
     
     (gtk:gtk-container-add window frame)
     (gtk:gtk-container-add frame area)

     ;; ウィジェット表示
     (gtk:gtk-widget-show-all window))))
