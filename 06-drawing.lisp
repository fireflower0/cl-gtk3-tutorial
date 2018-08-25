;; 06 お絵かき

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

;; メイン関数
(defun main ()
  ;; GTK+3を初期化し、メインループに入る
  (gtk:within-main-loop
   (let (;; タイトルとデフォルトの幅・高さを持つトップレベルウィンドウを作成
         (window (make-instance 'gtk:gtk-window
                                :type :toplevel
                                :title "Drawing"))
         (frame  (make-instance 'gtk:gtk-frame
                                :shadow-type :in))
         (area   (make-instance 'gtk:gtk-drawing-area
                                :width-request  250
                                :height-request 200))
         (surface nil))

     ;; destroy シグナルをラムダ関数と結びつける
     (gobject:g-signal-connect window "destroy"
                               (lambda (widget)
                                 (declare (ignore widget))
                                 (gtk:leave-gtk-main)))

     ;; draw シグナルをラムダ関数と結びつける
     (gobject:g-signal-connect area "draw"
                               (lambda (widget cr)
                                 (declare (ignore widget))
                                 (let ((cr (gobject:pointer cr)))
                                   (cairo:cairo-set-source-surface cr surface 0.0 0.0)
                                   (cairo:cairo-paint cr)
                                   (cairo:cairo-destroy cr)
                                   gdk:+gdk-event-propagate+)))
     
     (gobject:g-signal-connect area "configure-event"
                               (lambda (widget event)
                                 (declare (ignore event))
                                 (when surface
                                   (cairo:cairo-surface-destroy surface))
                                 (setf surface
                                       (gdk:gdk-window-create-similar-surface
                                        (gtk:gtk-widget-window widget)
                                        :color
                                        (gtk:gtk-widget-get-allocated-width widget)
                                        (gtk:gtk-widget-get-allocated-height widget)))
                                 ;; Clear surface
                                 (let ((cr (cairo:cairo-create surface)))
                                   (cairo:cairo-set-source-rgb cr 1.0 1.0 1.0)
                                   (cairo:cairo-paint cr)
                                   (cairo:cairo-destroy cr))
                                 (format t "leave event 'configure-event'~%")
                                 gdk:+gdk-event-stop+))
     
     ;; イベントシグナル
     (gobject:g-signal-connect area "motion-notify-event"
                               (lambda (widget event)
                                 (format t "MOTION-NOTIFY-EVENT ~A~%" event)
                                 (when (member :button1-mask (gdk:gdk-event-motion-state event))
                                   (let ((cr (cairo:cairo-create surface))
                                         (x  (gdk:gdk-event-motion-x event))
                                         (y  (gdk:gdk-event-motion-y event)))
                                     (cairo:cairo-rectangle cr (- x 3.0) (- y 3.0) 6.0 6.0)
                                     (cairo:cairo-fill cr)
                                     (cairo:cairo-destroy cr)
                                     (gtk:gtk-widget-queue-draw-area widget
                                                                     (truncate (- x 3.0))
                                                                     (truncate (- y 3.0))
                                                                     6
                                                                     6)))
                                 ;; イベントを処理し、停止
                                 gdk:+gdk-event-stop+))
     
     (gobject:g-signal-connect area "button-press-event"
                               (lambda (widget event)
                                 (format t "BUTTON-PRESS-EVENT ~A~%" event)
                                 (if (eql 1 (gdk:gdk-event-button-button event))
                                     (let ((cr (cairo:cairo-create surface))
                                           (x  (gdk:gdk-event-button-x event))
                                           (y  (gdk:gdk-event-button-y event)))
                                       (cairo:cairo-rectangle cr (- x 3.0) (- y 3.0) 6.0 6.0)
                                       (cairo:cairo-fill cr)
                                       (cairo:cairo-destroy cr)
                                       (gtk:gtk-widget-queue-draw-area widget
                                                                       (truncate (- x 3.0))
                                                                       (truncate (- y 3.0))
                                                                       6
                                                                       6))
                                     ;; Clear surface
                                     (let ((cr (cairo:cairo-create surface)))
                                       (cairo:cairo-set-source-rgb cr 1.0 1.0 1.0)
                                       (cairo:cairo-paint cr)
                                       (cairo:cairo-destroy cr)
                                       (gtk:gtk-widget-queue-draw widget)))))
     
     (gtk:gtk-widget-add-events area
                                '(:button-press-mask
                                  :pointer-motion-mask))

     ;; ウィジェットをウィンドウに配置
     (gtk:gtk-container-add frame area)
     (gtk:gtk-container-add window frame)
     
     ;; 全てのウィジェット表示
     (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
