;; 40 ウィジェット挿入

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defun main ()
  (gtk:within-main-loop
    (let ((window    (make-instance 'gtk:gtk-window
                                    :type :toplevel
                                    :title "Multiline Text Widget"
                                    :default-width 300
                                    :default-height 200))
          (text-view (make-instance 'gtk:gtk-text-view
                                    :hexpand t
                                    :vexpand t))
          (button    (make-instance 'gtk:gtk-button
                                    :label "Insert Widget"))
          (vbox      (make-instance 'gtk:gtk-grid
                                    :orientation :vertical)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; 現在のカーソル位置にウィジェットを挿入するシグナルハンドラ
      (gobject:g-signal-connect button "clicked"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (let* ((buffer (gtk:gtk-text-view-buffer text-view))
                                         (cursor (gtk:gtk-text-buffer-get-insert buffer))
                                         (iter   (gtk:gtk-text-buffer-get-iter-at-mark buffer cursor))
                                         (anchor (gtk:gtk-text-buffer-create-child-anchor buffer iter))
                                         (button (gtk:gtk-button-new-with-label "New Button")))
                                    (gtk:gtk-text-view-add-child-at-anchor text-view button anchor)
                                    (gtk:gtk-widget-show button))))
      
      (gtk:gtk-container-add vbox text-view)
      (gtk:gtk-container-add vbox button)

      ;; ボックスをウィンドウに追加
      (gtk:gtk-container-add window vbox)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
