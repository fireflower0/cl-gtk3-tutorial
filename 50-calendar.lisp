;; 50 カレンダー

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defun main ()
  (gtk:within-main-loop
   (let ((window   (make-instance 'gtk:gtk-window
                                  :title "Calendar"
                                  :type :toplevel
                                  :border-width 24
                                  :default-width 250
                                  :default-height 100))
         (frame    (make-instance 'gtk:gtk-frame))
         (calendar (make-instance 'gtk:gtk-calendar
                                  :show-details nil)))

     ;; destroy シグナルをラムダ関数と結びつける
     (gobject:g-signal-connect window "destroy"
                               (lambda (widget)
                                 (declare (ignore widget))
                                 (gtk:leave-gtk-main)))

     ;; シグナルハンドラを接続して、選択した日を印刷します
     (gobject:g-signal-connect calendar "day-selected"
                       (lambda (widget)
                         (declare (ignore widget))
                         (format t "selected: year ~A month ~A day ~A~%"
                                 (gtk:gtk-calendar-year calendar)
                                 (gtk:gtk-calendar-month calendar)
                                 (gtk:gtk-calendar-day calendar))))

     ;; カレンダーの詳細機能をインストールする
     (gtk:gtk-calendar-set-detail-func calendar
                                   (lambda (calendar year month day)
                                     (declare (ignore calendar year month))
                                     (when (= day 12)
                                       "This day has a tooltip.")))

     ;; 1日をマークする
     (gtk:gtk-calendar-mark-day calendar 6)

     ;; カレンダーをフレームに入れ、フレームをウィンドウに入れる
     (gtk:gtk-container-add frame calendar)
     (gtk:gtk-container-add window frame)

     ;; ウィジェット表示
     (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
