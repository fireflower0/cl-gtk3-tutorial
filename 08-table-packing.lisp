;; 08 テーブルを使用したパッキング

(defpackage #:cl-gtk3-tutorial/08-table-packing
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/08-table-packing)

;; メイン関数
(defun main ()
  ;; GTK+3を初期化し、メインループに入る
  (gtk:within-main-loop
    (let (;; タイトルとデフォルトの幅・高さを持つトップレベルウィンドウを作成
          (window  (make-instance 'gtk:gtk-window
                                  :type  :toplevel
                                  :title "Table Packing"
                                  :border-width 12
                                  :default-width  300))
          (table   (make-instance 'gtk:gtk-table
                                  :n-column 2
                                  :n-rows 2
                                  :homogeneous t))
          (button1 (make-instance 'gtk:gtk-button
                                  :label "Button 1"))
          (button2 (make-instance 'gtk:gtk-button
                                  :label "Button 2"))
          (quit    (make-instance 'gtk:gtk-button
                                  :label "Quit")))
      
      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                ;; 終了処理 leave-gtk-main を呼び出す。
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; clicked シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect quit "clicked"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:gtk-widget-destroy window)))

      ;; パッキングテーブル
      ;;  0          1          2
      ;; 0+----------+----------+
      ;;  |          |          |
      ;; 1+----------+----------+
      ;;  |          |          |
      ;; 2+----------+----------+
      (gtk:gtk-table-attach table button1 0 1 0 1)
      (gtk:gtk-table-attach table button2 1 2 0 1)
      (gtk:gtk-table-attach table quit    0 2 1 2)

      ;; ウィジェットをウィンドウに配置
      (gtk:gtk-container-add window table)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
