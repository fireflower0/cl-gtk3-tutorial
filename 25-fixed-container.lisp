;; 25 固定コンテナ

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defun move-button (button fixed)
  (let* ((allocation (gtk:gtk-widget-get-allocation fixed))
         (width      (- (gdk:gdk-rectangle-width  allocation) 20))
         (height     (- (gdk:gdk-rectangle-height allocation) 10)))
    (gtk:gtk-fixed-move fixed button (random width) (random height))))

;; メイン関数
(defun main ()
  (gtk:within-main-loop
    (let* ((window (make-instance 'gtk:gtk-window
                                  :type :toplevel
                                  :title "Fixed Container"
                                  :default-width  300
                                  :default-height 200
                                  :border-width 12))
           (fixed  (make-instance 'gtk:gtk-fixed)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                ;; 終了処理 leave-gtk-main を呼び出す。
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      (gtk:gtk-container-add window fixed)

      (dotimes (n 3)
        (let ((button (gtk:gtk-button-new-with-label "Press me")))
          (gobject:g-signal-connect button "clicked"
                                    (lambda (widget)
                                      (move-button widget fixed)))
          (gtk:gtk-fixed-put fixed button (random 250) (random 150))))
      
      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
