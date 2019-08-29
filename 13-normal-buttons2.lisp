;; 13 ボタンを作成するその他の例

(defpackage #:cl-gtk3-tutorial/13-normal-buttons2
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/13-normal-buttons2)

;; メイン関数
(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :title "More Buttons"
                                 :type :toplevel
                                 :default-width 250
                                 :border-width 12))
          (vbox1  (make-instance 'gtk:gtk-box
                                 :orientation :vertical
                                 :spacing 6))
          (vbox2  (make-instance 'gtk:gtk-box
                                 :orientation :vertical
                                 :spacing 6))
          (hbox   (make-instance 'gtk:gtk-box
                                 :orientation :horizontal
                                 :spacing 6)))

      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; gtk-button-imagesをTに設定します。
      ;; これにより、テキストと画像のボタンが可能になります。
      (setf (gtk:gtk-settings-gtk-button-images (gtk:gtk-settings-get-default)) t)

      ;; これらは、ボタンを作成するための標準機能です。
      (gtk:gtk-box-pack-start vbox1 (gtk:gtk-button-new-with-label "Label"))
      (gtk:gtk-box-pack-start vbox1 (gtk:gtk-button-new-with-mnemonic "_Mnemoic"))
      (gtk:gtk-box-pack-start vbox1 (gtk:gtk-button-new-from-stock "gtk-apply"))

      ;; make-instanceでいくつかのボタンを作成します。
      (gtk:gtk-box-pack-start vbox2 (make-instance 'gtk:gtk-button
                                                   :image-position :right
                                                   :image (gtk:gtk-image-new-from-stock
                                                           "gtk-edit"
                                                           :button)
                                                   :label "gtk-edit"
                                                   :use-stock t))
      (gtk:gtk-box-pack-start vbox2 (make-instance 'gtk:gtk-button
                                                   :image-position :top
                                                   :image (gtk:gtk-image-new-from-stock
                                                           "gtk-cut"
                                                           :button)
                                                   :label "gtk-cut"
                                                   :use-stock t))
      (gtk:gtk-box-pack-start vbox2 (make-instance 'gtk:gtk-button
                                                   :image-position :bottom
                                                   :image (gtk:gtk-image-new-from-stock
                                                           "gtk-cancel"
                                                           :button)
                                                   :label "gtk-cancel"
                                                   :use-stock t))

      (gtk:gtk-box-pack-start hbox vbox1)
      (gtk:gtk-box-pack-start hbox vbox2)

      (gtk:gtk-container-add window hbox)
      
      (gtk:gtk-widget-show-all window))))
