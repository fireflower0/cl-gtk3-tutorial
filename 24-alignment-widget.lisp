;; 24 アライメントウィジェット

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

;; メイン関数
(defun main ()
  (gtk:within-main-loop
    (let* ((window (make-instance 'gtk:gtk-window
                                  :type :toplevel
                                  :title "Alignment"
                                  :border-width 12
                                  :width-request 300
                                  :height-request 300))
           (grid   (make-instance 'gtk:gtk-grid
                                  :column-spacing 12
                                  :column-homogeneous t
                                  :row-spacing 12
                                  :row-homogeneous t)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                ;; 終了処理 leave-gtk-main を呼び出す。
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      (let ((frame     (make-instance 'gtk:gtk-frame
                                      :label "xalign: 0, yalign: 0"))
            (button    (make-instance 'gtk:gtk-button
                                      :label "Button"))
            (alignment (make-instance 'gtk:gtk-alignment
                                      :xalign 0.00
                                      :yalign 0.00
                                      :xscale 0.50
                                      :yscale 0.25)))
        (gtk:gtk-alignment-set-padding alignment 6 6 6 6)
        (gtk:gtk-container-add alignment button)
        (gtk:gtk-container-add frame alignment)
        (gtk:gtk-grid-attach grid frame 0 1 1 1))

      (let ((frame     (make-instance 'gtk:gtk-frame
                                      :label "xalign: 0, yalign: 1"))
            (button    (make-instance 'gtk:gtk-button
                                      :label "Button"))
            (alignment (make-instance 'gtk:gtk-alignment
                                      :xalign 0.00
                                      :yalign 1.00
                                      :xscale 0.50
                                      :yscale 0.25)))
        (gtk:gtk-alignment-set-padding alignment 6 6 6 6)
        (gtk:gtk-container-add alignment button)
        (gtk:gtk-container-add frame alignment)
        (gtk:gtk-grid-attach grid frame 1 1 1 1))

      (let ((frame     (make-instance 'gtk:gtk-frame
                                      :label "xalign: 1, yalign: 0"))
            (button    (make-instance 'gtk:gtk-button
                                      :label "Button"))
            (alignment (make-instance 'gtk:gtk-alignment
                                      :xalign 1.00
                                      :yalign 0.00
                                      :xscale 0.50
                                      :yscale 0.25)))
        (gtk:gtk-alignment-set-padding alignment 6 6 6 6)
        (gtk:gtk-container-add alignment button)
        (gtk:gtk-container-add frame alignment)
        (gtk:gtk-grid-attach grid frame 0 2 1 1))

      (let ((frame     (make-instance 'gtk:gtk-frame
                                      :label "xalign: 1, yalign: 1"))
            (button    (make-instance 'gtk:gtk-button
                                      :label "Button"))
            (alignment (make-instance 'gtk:gtk-alignment
                                      :xalign 1.00
                                      :yalign 1.00
                                      :xscale 0.50
                                      :yscale 0.25)))
        (gtk:gtk-alignment-set-padding alignment 6 6 6 6)
        (gtk:gtk-container-add alignment button)
        (gtk:gtk-container-add frame alignment)
        (gtk:gtk-grid-attach grid frame 1 2 1 1))

      ;; ボックスをウィンドウに置き、ウィンドウを表示する
      (gtk:gtk-container-add window grid)
      
      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
