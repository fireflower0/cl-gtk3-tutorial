;; 30 ボタンボックス

(defpackage #:cl-gtk3-tutorial/30-button-boxes
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/30-button-boxes)

(defun create-bbox (orientation title spacing layout)
  (let ((frame (make-instance 'gtk:gtk-frame
                              :label title))
        (bbox  (make-instance 'gtk:gtk-button-box
                              :orientation orientation
                              :border-width 6
                              :layout-style layout
                              :spacing spacing)))
    (gtk:gtk-container-add bbox (gtk:gtk-button-new-from-stock "gtk-ok"))
    (gtk:gtk-container-add bbox (gtk:gtk-button-new-from-stock "gtk-cancel"))
    (gtk:gtk-container-add bbox (gtk:gtk-button-new-from-stock "gtk-help"))
    (gtk:gtk-container-add frame bbox)
    frame))

(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :type :toplevel
                                 :title "Button Box"
                                 :border-width 12))
          (vbox1  (make-instance 'gtk:gtk-box
                                 :orientation :vertical
                                 :homogeneous nil
                                 :spacing 12))
          (vbox2  (make-instance 'gtk:gtk-box
                                 :orientation :vertical
                                 :homogeneous nil
                                 :spacing 12))
          (hbox   (make-instance 'gtk:gtk-box
                                 :orientation :horizontal
                                 :homogeneous nil
                                 :spacing 12)))

      ;; gtk-button-imagesをTに設定します。
      ;; これにより、テキストと画像のボタンが可能になります。
      (setf (gtk:gtk-settings-gtk-button-images (gtk:gtk-settings-get-default)) t)

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; 水平ボタンボックスを作成する
      (gtk:gtk-box-pack-start vbox1
                              (make-instance 'gtk:gtk-label
                                             :ypad 6
                                             :xalign 0
                                             :use-markup t
                                             :label "<b>Horizontal Button Boxes</b>")
                              :expand nil
                              :fill nil)

      ;; 最初の水平ボックスを作成する
      (gtk:gtk-box-pack-start vbox2
                              (create-bbox :horizontal
                                           "Spread (spacing 12)"
                                           12
                                           :spread))

      ;; 第2の水平ボックスを作成する
      (gtk:gtk-box-pack-start vbox2
                              (create-bbox :horizontal
                                           "Edge (spacing 12)"
                                           12
                                           :edge))

      ;; 第3の水平ボックスを作成する
      (gtk:gtk-box-pack-start vbox2
                              (create-bbox :horizontal
                                           "Start (spacing 6)"
                                           6
                                           :start))

      (gtk:gtk-box-pack-start vbox1 vbox2)

      ;; 垂直ボタンボックスを作成する
      (gtk:gtk-box-pack-start vbox1
                              (make-instance 'gtk:gtk-label
                                             :ypad 12
                                             :xalign 0
                                             :use-markup t
                                             :label "<b>Vertical Button Boxes</b>")
                              :expand nil
                              :fill nil)

      ;; 最初の垂直ボックスを作成する
      (gtk:gtk-box-pack-start hbox
                              (create-bbox :vertical
                                           "Spread (spacing 12)"
                                           12
                                           :spread))

      ;; 第2の垂直ボックスを作成する
      (gtk:gtk-box-pack-start hbox
                              (create-bbox :vertical
                                           "Edge (spacing 12)"
                                           12
                                           :edge))

      ;; 第3の垂直ボックスを作成する
      (gtk:gtk-box-pack-start hbox
                              (create-bbox :vertical
                                           "Start (spacing 6)"
                                           6
                                           :start))

      ;; 第4の縦型ボックスを作成する
      (gtk:gtk-box-pack-start hbox
                              (create-bbox :vertical
                                           "End (spacing 6)"
                                           6
                                           :end))

      (gtk:gtk-box-pack-start vbox1 hbox)
      
      (gtk:gtk-container-add window vbox1)
      
      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
