;; 29 スクロールウィンドウ

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defun main ()
  (gtk:within-main-loop
    (let ((window   (make-instance 'gtk:gtk-dialog
                                   :type :toplevel
                                   :title "Scrolled Window"
                                   :border-width 0
                                   :width-request 350
                                   :height-request 300))
          (scrolled (make-instance 'gtk:gtk-scrolled-window
                                   :border-width 12
                                   :hscrollbar-policy :automatic
                                   :vscrollbar-policy :always))
          (table    (make-instance 'gtk:gtk-table
                                   :n-rows 10
                                   :n-columns 10
                                   :row-spacing 10
                                   :column-spacing 10
                                   :homogeneous nil)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      (gtk:gtk-box-pack-start (gtk:gtk-dialog-get-content-area window) scrolled)
      (gtk:gtk-scrolled-window-add-with-viewport scrolled table)
      
      (dotimes (i 10)
        (dotimes (j 10)
          (gtk:gtk-table-attach table
                                (make-instance 'gtk:gtk-button
                                               :label (format nil "(~d, ~d)" i j))
                                i (+ i 1) j (+ j 1))))

      (let ((button (make-instance 'gtk:gtk-button
                                   :label "Close"
                                   :can-default t)))
        (gobject:g-signal-connect button "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (gtk:gtk-widget-destroy window)))
        (gtk:gtk-box-pack-start (gtk:gtk-dialog-get-action-area window) button)
        (gtk:gtk-widget-grab-default button))
      
      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
