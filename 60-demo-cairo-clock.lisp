;; 60 Demo Cairo Clock

(ql:quickload :cl-cffi-gtk)

(defclass egg-clock-face (gtk:gtk-drawing-area)
  ((time :initarg  :time
         :initform (multiple-value-list (get-decoded-time))
         :accessor egg-clock-face-time))
  (:metaclass gobject:gobject-class))

(defmethod initialize-instance :after
    ((clock egg-clock-face) &key &allow-other-keys)
  (glib:g-timeout-add 1000
                      (lambda ()
                        (setf (egg-clock-face-time clock)
                              (multiple-value-list (get-decoded-time)))
                        (gtk:gtk-widget-queue-draw clock)
                        glib:+g-source-continue+))
  ;; 時計を描画するシグナルハンドラ
  (gobject:g-signal-connect clock "draw"
                            (lambda (widget cr)
                              (let ((cr (gobject:pointer cr))
                                    ;; ウィジェットのGdkWindowを取得する
                                    (window (gtk:gtk-widget-window widget)))
                                ;; surfaceクリア
                                (cairo:cairo-set-source-rgb cr 1.0 1.0 1.0)
                                (cairo:cairo-paint cr)
                                (let* ((x (/ (gdk:gdk-window-get-width  window) 2))
                                       (y (/ (gdk:gdk-window-get-height window) 2))
                                       (radius (- (min x y) 12)))
                                  ;; 時計背景
                                  (cairo:cairo-arc cr x y radius 0 (* 2 pi))
                                  (cairo:cairo-set-source-rgb cr 1 1 1)
                                  (cairo:cairo-fill-preserve cr)
                                  (cairo:cairo-set-source-rgb cr 0 0 0)
                                  (cairo:cairo-stroke cr)
                                  ;; 時計針
                                  )))))

(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :title "Cairo Clock"
                                 :default-width 250
                                 :default-height 250))
          (clock  (make-instance 'egg-clock-face)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; ウィンドウにクロックを追加
      (gtk:gtk-container-add window clock)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
