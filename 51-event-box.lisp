;; 51 イベントボックス

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defun main ()
  (gtk:within-main-loop
   (let ((window   (make-instance 'gtk:gtk-window
                                  :type :toplevel
                                  :title "Event Box"
                                  :border-width 12))
         (eventbox (make-instance 'gtk:gtk-event-box))
         (label    (make-instance 'gtk:gtk-label
                                  :label "Click here to quit, and more text, more")))

     ;; destroy シグナルをラムダ関数と結びつける
     (gobject:g-signal-connect window "destroy"
                               (lambda (widget)
                                 (declare (ignore widget))
                                 (gtk:leave-gtk-main)))

     ;; イベントボックスのイベントを設定する
     (setf (gtk:gtk-widget-events eventbox) :button-press-mask)

     ;; イベントボックスに信号を接続する
     (gobject:g-signal-connect eventbox "button-press-event"
                               (lambda (widget event)
                                 (declare (ignore widget event))
                                 (gtk:gtk-widget-destroy window)))

     ;; イベントボックスにラベルを追加し、ウィンドウにイベントボックスを追加する
     (gtk:gtk-container-add eventbox label)
     (gtk:gtk-container-add window eventbox)

     ;; イベントボックスを実現する
     (gtk:gtk-widget-realize eventbox)

     ;; イベントボックスの新しいカーソルを設定する
     ;; (gdk:gdk-window-set-cursor (gtk:gtk-widget-window eventbox)
     ;;                            (gdk:gdk-cursor-new :hand1))

     ;; ウィンドウ表示
     (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
