;; 12 画像とラベルが付いたボタン

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defun image-label-box (filename text)
  (let ((box   (make-instance 'gtk:gtk-box
                              :orientation :horizontal
                              :border-width 3))
        (label (make-instance 'gtk:gtk-label
                              :label text))
        (image (gtk:gtk-image-new-from-file filename)))
    (gtk:gtk-box-pack-start box image :expand nil :fill nil :padding 3)
    (gtk:gtk-box-pack-start box label :expand nil :fill nil :padding 3)
    box))

;; メイン関数
(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :title "Image label Button"
                                 :type :toplevel
                                 :border-width 12))
          (button (make-instance 'gtk:gtk-button))
          (box    (image-label-box "Material/icons/save.png" "Save to File")))

      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      (gtk:gtk-container-add button box)
      (gtk:gtk-container-add window button)
      
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
