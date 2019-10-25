;; 55 コンボボックステキスト

(defpackage #:cl-gtk3-tutorial/55-combo-box-text
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/55-combo-box-text)

(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :border-width 12
                                 :default-width 320
                                 :title "Combo Box Text"))
          (combo  (make-instance 'gtk:gtk-combo-box-text)))

      (gtk:gtk-combo-box-text-append-text combo "First entry")
      (gtk:gtk-combo-box-text-append-text combo "Second entry")
      (gtk:gtk-combo-box-text-append-text combo "Third entry")
      (gtk:gtk-combo-box-active combo)

      ;; コンボボックスをウィンドウに入れる
      (gtk:gtk-container-add window combo)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
