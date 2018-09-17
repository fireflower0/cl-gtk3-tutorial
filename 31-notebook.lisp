;; 31 ノートブック

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defun main ()
  (gtk:within-main-loop
    (let ((window   (make-instance 'gtk:gtk-window
                                   :title "Notebook"
                                   :type :toplevel
                                   :default-width 250
                                   :default-height 200))
          (expander (make-instance 'gtk:gtk-expander
                                   :expanded t
                                   :label "Notebook"))
          (notebook (make-instance 'gtk:gtk-notebook
                                   :enable-popup t)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      (dotimes (i 5)
        (let ((page       (make-instance 'gtk:gtk-label
                                         :label (format nil "Text for page ~A" i)))
              (tab-label  (make-instance 'gtk:gtk-label
                                         :label (format nil "Tab ~A" i)))
              (tab-button (make-instance 'gtk:gtk-button
                                         :image (make-instance 'gtk:gtk-image
                                                               :stock "gtk-close"
                                                               :icon-size 1)
                                         :relief :none)))
          (gobject:g-signal-connect tab-button "clicked"
                                    (let ((page page))
                                      (lambda (button)
                                        (declare (ignore button))
                                        (format t "Removing page ~A~%" page)
                                        (gtk:gtk-notebook-remove-page notebook page))))
          (let ((tab-hbox (make-instance 'gtk:gtk-box
                                         :orientation :horizontal)))
            (gtk:gtk-box-pack-start tab-hbox tab-label)
            (gtk:gtk-box-pack-start tab-hbox tab-button)
            (gtk:gtk-widget-show-all tab-hbox)
            (gtk:gtk-notebook-add-page notebook page tab-hbox))))

      (gtk:gtk-container-add expander notebook)
      (gtk:gtk-container-add window expander)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
