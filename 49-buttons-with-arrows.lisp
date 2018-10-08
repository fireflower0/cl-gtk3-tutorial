;; 49 矢印付きボタン

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defun create-arrow-button (arrow-type shadow-type)
  (let (;; ボタンを作成する
        (button (make-instance 'gtk:gtk-button
                               ;; ボタンの周りに小さな余白を追加する
                               :margin 3
                               ;; 75 x 75サイズの大きいボタンを作る
                               :width-request 75
                               :height-request 75)))

    ;; ボタンに矢印を追加する
    (gtk:gtk-container-add button (make-instance 'gtk:gtk-arrow
                                                 :arrow-type arrow-type
                                                 :shadow-type shadow-type))

    ;; ボタンにツールチップを追加する
    (setf (gtk:gtk-widget-tooltip-text button)
          (format nil "Arrow of type ~A" (symbol-name arrow-type)))

    button))

(defun main ()
  (gtk:within-main-loop
    (let ((;; メインウィンドウを作成する
           window (make-instance 'gtk:gtk-window
                                 :type :toplevel
                                 :title "Arrow Buttons"
                                 :default-width 275
                                 :default-height 125
                                 :border-width 12))
          ;; ボタンのグリッドを作成する
          (grid   (make-instance 'gtk:gtk-grid
                                 :orientation :horizontal
                                 :column-homogeneous t)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; 矢印付きのボタンを作成し、ボタンをグリッドに追加する
      (gtk:gtk-container-add grid (create-arrow-button :up :in))
      (gtk:gtk-container-add grid (create-arrow-button :down :out))
      (gtk:gtk-container-add grid (create-arrow-button :left :etched-in))
      (gtk:gtk-container-add grid (create-arrow-button :right :etched-out))


      ;; グリッドをウィンドウに追加
      (gtk:gtk-container-add window grid)
      
      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
