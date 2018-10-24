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
                                  ;; 時分刻み
                                  (let ((inset 0.0)
                                        (angle 0.0))
                                    (dotimes (i 12)
                                      (cairo:cairo-save cr)
                                      (setf angle (/ (* i pi) 6))
                                      (if (eql 0 (mod i 3))
                                          (setf inset (* 0.2 radius))
                                          (progn
                                            (setf inset (* 0.1 radius))
                                            (cairo:cairo-set-line-width cr
                                                                        (* 0.5 (cairo:cairo-get-line-width cr)))))
                                      (cairo:cairo-move-to cr
                                                           (+ x (* (- radius inset) (cos angle)))
                                                           (+ y (* (- radius inset) (sin angle))))
                                      (cairo:cairo-line-to cr
                                                           (+ x (* radius (cos angle)))
                                                           (+ y (* radius (sin angle))))
                                      (cairo:cairo-stroke cr)
                                      (cairo:cairo-restore cr)))
                                  ;; 時計の針
                                  (let ((seconds (first  (egg-clock-face-time clock)))
                                        (minutes (second (egg-clock-face-time clock)))
                                        (hours   (third  (egg-clock-face-time clock))))
                                    ;; 時針は1時間に30度（π/ 6r）回転します
                                    ;; + 1/2度（π/ 360r）/分
                                    (let ((hours-angle   (* (/ pi 6) hours))
                                          (minutes-angle (* (/ pi 360) minutes)))
                                      (cairo:cairo-save cr)
                                      (cairo:cairo-set-line-width cr (* 2.5 (cairo:cairo-get-line-width cr)))
                                      (cairo:cairo-move-to cr x y)
                                      (cairo:cairo-line-to cr
                                                           (+ x (* (/ radius 2)
                                                                   (sin (+ hours-angle minutes-angle))))
                                                           (+ y (* (/ radius 2)
                                                                   (- (cos (+ hours-angle minutes-angle))))))
                                      (cairo:cairo-stroke cr)
                                      (cairo:cairo-restore cr))
                                    ;; 分針は毎分6度（π/ 30r）回転します
                                    (let ((angle (* (/ pi 30) minutes)))
                                      (cairo:cairo-move-to cr x y)
                                      (cairo:cairo-line-to cr
                                                           (+ x (* radius 0.75 (sin angle)))
                                                           (+ y (* radius 0.75 (- (cos angle)))))
                                      (cairo:cairo-stroke cr))
                                    )
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
