;; 55 コンボボックステキスト

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)


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
      (gtk:gtk-combo-box-set-active combo 0)

      ;; コンボボックスをウィンドウに入れる
      (gtk:gtk-container-add window combo)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
