;; 04 ボタン付きプログラム2

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

;; メイン関数
(defun main ()
  ;; GTK+3を初期化し、メインループに入る
  (gtk:within-main-loop
    (let (;; トップレベルのウィンドウを作成
          (window (gtk:gtk-window-new :toplevel))
          ;; ウィジェットをパックするためのボックスを作成
          (box    (gtk:gtk-box-new :horizontal 6))
          (button  nil))
      
      ;; ウィンドウのタイトル/サイズを設定
      (setf (gtk:gtk-window-title window) "Hello, Buttons")
      (setf (gtk:gtk-window-default-size window) '(250 75))
      ;; ウィンドウの境界線の幅を設定
      (setf (gtk:gtk-container-border-width window) 12)

      ;; ラベル付きボタン1を作成
      (setf button (gtk:gtk-button-new-with-label "Button 1"))

      ;; ボタン1の clicked シグナルを処理するシグナルハンドラ
      (gobject:g-signal-connect button "clicked"
                                ;; クリック時の処理 (標準出力し、ウィンドウを閉じる)
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (format t "Button 1 was pressed~%")))

      ;; ボタン1をボックスにパッキングする
      (gtk:gtk-box-pack-start box button :expand t :fill t :padding 0)

      ;; ラベル付きボタン2を作成
      (setf button (gtk:gtk-button-new-with-label "Button 2"))

      ;; ボタン2の clicked シグナルを処理するシグナルハンドラ
      (gobject:g-signal-connect button "clicked"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (format t "Button 2 was pressed~%")))

      ;; ボタン2をボックスにパッキングする
      (gtk:gtk-box-pack-start box button :expand t :fill t :padding 0)
      
      ;; ボックスをウィンドウに配置
      (gtk:gtk-container-add window box)
      ;; 全てのウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
