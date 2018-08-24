;; 01 シンプルウィンドウ

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

;; メイン関数
(defun main ()
  ;; GTK+3を初期化し、メインループに入る
  (gtk:within-main-loop
   ;; トップレベルウィンドウを作成
   (let ((window (gtk:gtk-window-new :toplevel)))
     ;; destroy シグナルをラムダ関数と結びつける
     (gobject:g-signal-connect window "destroy"
                               ;; 終了処理 leave-gtk-main を呼び出す。
                               (lambda (widget)
                                 (declare (ignore widget))
                                 (gtk:leave-gtk-main)))
     ;; ウィジェット表示
     (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
