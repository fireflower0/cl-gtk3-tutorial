;; 45 カラーボタン

(defpackage #:cl-gtk3-tutorial/45-color-button
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/45-color-button)

(defvar *color* (gdk:gdk-rgba-parse "Gray"))

(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :title "Color Button"
                                 :border-width 12
                                 :default-width 250
                                 :default-height 200))
          (button (make-instance 'gtk:gtk-color-button
                                 :rgba *color*)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      (gobject:g-signal-connect button "color-set"
                                (lambda (widget)
                                  (let ((rgba (gtk:gtk-color-chooser-rgba widget)))
                                    (format t "Selected color is ~A~%"
                                            (gdk:gdk-rgba-to-string rgba)))))
      
      (gtk:gtk-container-add window button)
      
      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
