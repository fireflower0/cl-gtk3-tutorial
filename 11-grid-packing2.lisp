;; 11 グリッドを使用したパッキング2

(defpackage #:cl-gtk3-tutorial/11-grid-packing2
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/11-grid-packing2)

;; メイン関数
(defun main ()
  ;; GTK+3を初期化し、メインループに入る
  (gtk:within-main-loop
    (let (;; タイトルとデフォルトの幅・高さを持つトップレベルウィンドウを作成
          (window  (make-instance 'gtk:gtk-window
                                  :type  :toplevel
                                  :title "Grid Packing"
                                  :border-width 12
                                  :default-width  300))
          (grid    (make-instance 'gtk:gtk-grid
                                  :column-homogeneous t
                                  :row-homogeneous t))
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

      ;; パッキンググリッド
      ;;  0          1          2
      ;; 0+----------+----------+
      ;;  |          |          |
      ;; 1+----------+----------+
      ;;  |          |          |
      ;; 2+----------+----------+
      (gtk:gtk-grid-attach grid button1 0 1 1 1)
      (gtk:gtk-grid-attach grid button2 1 1 1 1)
      (gtk:gtk-grid-attach grid quit    0 2 2 1)

      ;; ウィジェットをウィンドウに配置
      (gtk:gtk-container-add window grid)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
