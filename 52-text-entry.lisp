;; 52 テキスト入力

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defun main ()
  (gtk:within-main-loop
    (let* ((window (make-instance 'gtk:gtk-window
                                  :type :toplevel
                                  :title "Text Entry"
                                  :default-width 250))
           (vbox   (make-instance 'gtk:gtk-vbox))
           (hbox   (make-instance 'gtk:gtk-hbox))
           (entry  (make-instance 'gtk:gtk-entry
                                  :text "Hello"
                                  :max-length 50))
           (pos    (gtk:gtk-entry-text-length entry)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      (gobject:g-signal-connect entry "activate"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (format t "Entry contents: ~A"
                                          (gtk:gtk-entry-text entry))))

      (gtk:gtk-editable-insert-text entry " ,world!" pos)
      (gtk:gtk-editable-select-region entry 0 (gtk:gtk-entry-text-length entry))
      (gtk:gtk-box-pack-start vbox entry :expand t :fill t :padding 0)

      (let ((check (gtk:gtk-check-button-new-with-label "Editable")))
        (gobject:g-signal-connect check "toggled"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (gtk:gtk-editable-set-editable
                                     entry
                                     (gtk:gtk-toggle-button-active check))))
        (gtk:gtk-box-pack-start hbox check))

      (let ((check (gtk:gtk-check-button-new-with-label "Visible")))
        (setf (gtk:gtk-toggle-button-active check) t)
        (gobject:g-signal-connect check "toggled"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (setf (gtk:gtk-entry-visibility entry)
                                          (gtk:gtk-toggle-button-active check))))
        (gtk:gtk-box-pack-start hbox check))

      (gtk:gtk-box-pack-start vbox hbox)

      (let ((button (gtk:gtk-button-new-from-stock "gtk-close")))
        (gobject:g-signal-connect button "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (gtk:gtk-widget-destroy window)))
        (gtk:gtk-box-pack-start vbox button))

      ;; ボックスをウィンドウに追加
      (gtk:gtk-container-add window vbox)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
