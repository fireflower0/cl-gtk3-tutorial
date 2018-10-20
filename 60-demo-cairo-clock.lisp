;; 60 Demo Cairo Clock

(ql:quickload :cl-cffi-gtk)

(defclass egg-clock-face (gtk:gtk-drawing-area)
  ((time :initarg  :time
         :initform (multiple-value-list (get-decoded-time))
         :accessor egg-clock-face-time))
  (:metaclass gobject:gobject-class))

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
