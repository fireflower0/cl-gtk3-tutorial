;; 37 テキストの読み込みと変更

(defpackage #:cl-gtk3-tutorial/37-examing-modify-text
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/37-examing-modify-text)

(defun main ()
  (gtk:within-main-loop
    (let ((window    (make-instance 'gtk:gtk-window
                                    :title "Multiline Text Editing"
                                    :type :toplevel
                                    :default-width 300
                                    :default-height 200))
          (text-view (make-instance 'gtk:gtk-text-view
                                    :hexpand t
                                    :vexpand t))
          (button    (make-instance 'gtk:gtk-button
                                    :label "Make List Item"))
          (vbox      (make-instance 'gtk:gtk-grid
                                    :orientation :vertical)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      (gobject:g-signal-connect button "clicked"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (let* ((buffer (gtk:gtk-text-view-buffer text-view))
                                         (cursor (gtk:gtk-text-buffer-get-mark buffer "insert"))
                                         (iter   (gtk:gtk-text-buffer-get-iter-at-mark buffer cursor)))
                                    (gtk:gtk-text-iter-set-line-offset iter 0)
                                    (gtk:gtk-text-buffer-insert buffer "<li>" :position iter)
                                    (gtk:gtk-text-iter-forward-to-line-end iter)
                                    (gtk:gtk-text-buffer-insert buffer "</li>" :position iter))))
      
      (gtk:gtk-text-buffer-insert (gtk:gtk-text-view-buffer text-view)
                                  (format nil "Item 1~%Item 2~%Item 3~%"))
      
      (gtk:gtk-container-add vbox text-view)
      (gtk:gtk-container-add vbox button)

      ;; ボックスをウィンドウに追加
      (gtk:gtk-container-add window vbox)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
