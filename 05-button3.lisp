;; 05 ボタン付きプログラム3

(defpackage #:cl-gtk3-tutorial/05-button3
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/05-button3)

;; メイン関数
(defun main ()
  ;; GTK+3を初期化し、メインループに入る
  (gtk:within-main-loop
    (let (;; トップレベルのウィンドウを作成
          (window (make-instance 'gtk:gtk-window
                                 :type :toplevel
                                 :title "Hello, Buttons"
                                 :default-width  250
                                 :default-height 75
                                 :border-width   12))
          ;; ウィジェットをパックするためのボックスを作成
          (box    (make-instance 'gtk:gtk-box
                                 :orientation :horizontal
                                 :spacing 6)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; ラベル付きボタン作成
      (let ((button (gtk:gtk-button-new-with-label "Button 1")))
        ;; ボタン1の clicked シグナルを処理するシグナルハンドラ
        (gobject:g-signal-connect button "clicked"
                                  ;; クリック時の処理 (標準出力し、ウィンドウを閉じる)
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (format t "Button 1 was pressed~%")))
        (gtk:gtk-box-pack-start box button))

      ;; ラベル付きボタン作成
      (let ((button (gtk:gtk-button-new-with-label "Button 2")))
        ;; ボタン2の clicked シグナルを処理するシグナルハンドラ
        (gobject:g-signal-connect button "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (format t "Button 2 was pressed~%")))
        (gtk:gtk-box-pack-start box button))
      
      ;; ボックスをウィンドウに配置
      (gtk:gtk-container-add window box)
      ;; 全てのウィジェット表示
      (gtk:gtk-widget-show-all window))))
