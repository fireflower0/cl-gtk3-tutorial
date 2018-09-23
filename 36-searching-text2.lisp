;; 36 テキストビューでテキストを検索2

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defvar *some-text* "こんにちは、世界！")

(defun find-text (text-view text iter)
  (let ((buffer (gtk:gtk-text-view-buffer text-view)))
    (multiple-value-bind (found start end)
        (gtk:gtk-text-iter-search iter text)
      (when found
        (gtk:gtk-text-buffer-select-range buffer start end)
        (let ((last-pos (gtk:gtk-text-buffer-create-mark buffer "last-pos" end)))
          (gtk:gtk-text-view-scroll-mark-onscreen text-view last-pos))))))

(defun main ()
  (gtk:within-main-loop
    (let ((window        (make-instance 'gtk:gtk-window
                                        :title "Multiline Text Search"
                                        :type :toplevel
                                        :default-width 450
                                        :default-height 200))
          (entry         (make-instance 'gtk:gtk-entry))
          (button-search (make-instance 'gtk:gtk-button
                                        :label "Search"))
          (button-next   (make-instance 'gtk:gtk-button
                                        :label "Next"))
          (scrolled      (make-instance 'gtk:gtk-scrolled-window))
          (text-view     (make-instance 'gtk:gtk-text-view
                                        :hexpand t
                                        :vexpand t))
          (vbox          (make-instance 'gtk:gtk-grid
                                        :orientation :vertical))
          (hbox          (make-instance 'gtk:gtk-grid
                                        :orientation :horizontal)))
      
      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      (gobject:g-signal-connect button-search "clicked"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (let* ((text   (gtk:gtk-entry-text entry))
                                         (buffer (gtk:gtk-text-view-buffer text-view))
                                         (iter   (gtk:gtk-text-buffer-get-start-iter buffer)))
                                    (find-text text-view text iter))))
      
      (gobject:g-signal-connect button-next "clicked"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (let* ((text     (gtk:gtk-entry-text entry))
                                         (buffer   (gtk:gtk-text-view-buffer text-view))
                                         (last-pos (gtk:gtk-text-buffer-get-mark buffer "last-pos")))
                                    (when last-pos
                                      (find-text text-view
                                                 text
                                                 (gtk:gtk-text-buffer-get-iter-at-mark buffer
                                                                                   last-pos))))))
      
      (gtk:gtk-text-buffer-set-text (gtk:gtk-text-view-buffer text-view) *some-text*)
      
      (gtk:gtk-container-add scrolled text-view)
      (gtk:gtk-container-add hbox entry)
      (gtk:gtk-container-add hbox button-search)
      (gtk:gtk-container-add hbox button-next)
      (gtk:gtk-container-add vbox hbox)
      (gtk:gtk-container-add vbox scrolled)
      
      ;; ボックスをウィンドウに追加
      (gtk:gtk-container-add window vbox)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
