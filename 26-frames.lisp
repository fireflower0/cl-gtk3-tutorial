;; 26 フレーム

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

;; メイン関数
(defun main ()
  (gtk:within-main-loop
   (let ((window (make-instance 'gtk:gtk-window
                                :type :toplevel
                                :title "Frame"
                                :default-width 250
                                :default-height 200
                                :border-width 12))
         (frame (make-instance 'gtk:gtk-frame
                               :label "Gtk Frame Widget"
                               :label-xalign 1.0
                               :label-yalign 0.5
                               :shadow-type :etched-in)))

     ;; destroy シグナルをラムダ関数と結びつける
     (gobject:g-signal-connect window "destroy"
                       (lambda (widget)
                         (declare (ignore widget))
                         (gtk:leave-gtk-main)))
     
     (gtk:gtk-container-add window frame)

     ;; ウィジェット表示
     (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
