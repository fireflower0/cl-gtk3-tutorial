;; 02 シンプルウィンドウ2

(defpackage #:cl-gtk3-tutorial/02-simple-window2
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/02-simple-window2)

;; メイン関数
(defun main ()
  ;; GTK+3を初期化し、メインループに入る
  (gtk:within-main-loop
    (let (;; タイトルとデフォルトの幅・高さを持つトップレベルウィンドウを作成
          (window (make-instance 'gtk:gtk-window
                                 :type  :toplevel
                                 :title "Hello, world!"
                                 :default-width  640
                                 :default-height 480)))
      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                ;; 終了処理 leave-gtk-main を呼び出す。
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))
      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
