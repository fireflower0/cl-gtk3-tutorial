;; 09 テーブルを使用したパッキング2

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

;; メイン関数
(defun main ()
  ;; GTK+3を初期化し、メインループに入る
  (gtk:within-main-loop
    (let (;; タイトルとデフォルトの幅・高さを持つトップレベルウィンドウを作成
          (window  (make-instance 'gtk:gtk-window
                                  :type :toplevel
                                  :title "Example Table Packing"
                                  :border-width 12
                                  :default-width 300))
          (table   (make-instance 'gtk:gtk-table
                                  :n-columns 2
                                  :n-rows 2
                                  :homogeneous t))
          (button1 (make-instance 'gtk:gtk-toggle-button
                                  :label "More Row Spacing"))
          (button2 (make-instance 'gtk:gtk-toggle-button
                                  :label "More Col Spacing"))
          (quit    (make-instance 'gtk:gtk-button
                                  :label "Quit")))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; トグルボタン1
      (gobject:g-signal-connect button1 "toggled"
                                (lambda (widget)
                                  (if (gtk:gtk-toggle-button-active widget)
                                      (progn
                                        (gtk:gtk-table-set-row-spacings table 12)
                                        (setf (gtk:gtk-button-label widget) "Less Row Spacing"))
                                      (progn
                                        (gtk:gtk-table-set-row-spacings table 0)
                                        (setf (gtk:gtk-button-label widget) "More Row Spacing")))))

      ;; トグルボタン2
      (gobject:g-signal-connect button2 "toggled"
                                (lambda (widget)
                                  (if (gtk:gtk-toggle-button-active widget)
                                      (progn
                                        (gtk:gtk-table-set-col-spacings table 12)
                                        (setf (gtk:gtk-button-label widget) "Less Col Spacing"))
                                      (progn
                                        (gtk:gtk-table-set-col-spacings table 0)
                                        (setf (gtk:gtk-button-label widget) "More Col Spacing")))))

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

;; main関数を呼び出して実行
(main)
