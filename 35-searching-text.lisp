;; 35 テキストビューでテキストを検索

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defvar *some-text* "こんにちは、世界！")

(defun main ()
  (gtk:within-main-loop
   (let* ((window    (make-instance 'gtk:gtk-window
                                    :title "Text View Search"
                                    :type :toplevel
                                    :default-width 300
                                    :default-height 200))
          (entry     (make-instance 'gtk:gtk-entry))
          (button    (make-instance 'gtk:gtk-button
                                    :label "Search"))
          (scrolled  (make-instance 'gtk:gtk-scrolled-window))
          (text-view (make-instance 'gtk:gtk-text-view
                                    :wrap-mode :word
                                    :hexpand t
                                    :vexpand t))
          (vbox      (make-instance 'gtk:gtk-grid
                                    :orientation :vertical))
          (hbox      (make-instance 'gtk:gtk-grid
                                    :orientation :horizontal)))

     ;; destroy シグナルをラムダ関数と結びつける
     (gobject:g-signal-connect window "destroy"
                               (lambda (widget)
                                 (declare (ignore widget))
                                 (gtk:leave-gtk-main)))

     ;; 検索ボタンのシグナルハンドラ
     (gobject:g-signal-connect button "clicked"
                               (lambda (widget)
                                 (declare (ignore widget))
                                 (let* ((text   (gtk:gtk-entry-text entry))
                                        (buffer (gtk:gtk-text-view-buffer text-view))
                                        (iter   (gtk:gtk-text-buffer-get-start-iter buffer)))
                                   (multiple-value-bind (found start end)
                                       (gtk:gtk-text-iter-search iter text)
                                     (when found
                                       (gtk:gtk-text-buffer-select-range buffer start end))))))

     (gtk:gtk-text-buffer-set-text (gtk:gtk-text-view-buffer text-view) *some-text*)
     
     (gtk:gtk-container-add scrolled text-view)
     (gtk:gtk-container-add hbox entry)
     (gtk:gtk-container-add hbox button)
     (gtk:gtk-container-add vbox hbox)
     (gtk:gtk-container-add vbox scrolled)

     ;; ボックスをウィンドウに追加
     (gtk:gtk-container-add window vbox)

     ;; ウィジェット表示
     (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
