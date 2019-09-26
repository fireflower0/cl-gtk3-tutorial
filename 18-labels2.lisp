;; 18 ラベル2

(defpackage #:cl-gtk3-tutorial/18-labels2
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/18-labels2)

;; メイン関数
(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :type  :toplevel
                                 :title "Labels2"
                                 :default-width 300
                                 :border-width 6))
          (vbox1  (make-instance 'gtk:gtk-box
                                 :orientation :vertical
                                 :spacing 6))
          (vbox2  (make-instance 'gtk:gtk-box
                                 :orientation :vertical
                                 :spacing 6))
          (hbox   (make-instance 'gtk:gtk-box
                                 :orientation :horizontal
                                 :spacing 12)))
      
      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                ;; 終了処理 leave-gtk-main を呼び出す。
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      (gtk:gtk-box-pack-start hbox
                              (make-instance 'gtk:gtk-label
                                             :label "Angle 90°"
                                             :angle 90))

      (gtk:gtk-box-pack-start vbox1
                              (make-instance 'gtk:gtk-label
                                             :label "Angle 45°"
                                             :angle 45))

      (gtk:gtk-box-pack-start vbox1
                              (make-instance 'gtk:gtk-label
                                             :label "Angle 315°"
                                             :angle 315))

      (gtk:gtk-box-pack-start hbox vbox1)

      (gtk:gtk-box-pack-start hbox
                              (make-instance 'gtk:gtk-label
                                             :label "Angle 270°"
                                             :angle 270))

      (gtk:gtk-box-pack-start vbox2 hbox)

      (gtk:gtk-box-pack-start vbox2 (make-instance 'gtk:gtk-hseparator))
      (gtk:gtk-box-pack-start vbox2 (gtk:gtk-label-new "Normal Label"))
      (gtk:gtk-box-pack-start vbox2 (gtk:gtk-label-new-with-mnemonic "With _Mnemonic"))
      
      (gtk:gtk-box-pack-start vbox2 (make-instance 'gtk:gtk-label
                                                   :label "This Label is Selectable"
                                                   :selectable t))

      (gtk:gtk-box-pack-start vbox2 (make-instance 'gtk:gtk-label
                                                   :label "<small>Small text</small>"
                                                   :use-markup t))

      (gtk:gtk-box-pack-start vbox2 (make-instance 'gtk:gtk-label
                                                   :label "<b>Bold text</b>"
                                                   :use-markup t))

      (gtk:gtk-box-pack-start vbox2 (make-instance 'gtk:gtk-label
                                                   :use-markup t
                                                   :label (format nil "Go to the ~
                                                                       <a href=\"https://www.gtk.org/\">~
                                                                       GTK+ Website</a> for more ...")))
      
      ;; ボックスをウィンドウに置き、ウィンドウを表示する
      (gtk:gtk-container-add window vbox2)
      
      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
