;; 38 テキストの読み込みと変更2

(defpackage #:cl-gtk3-tutorial/38-examing-modify-text2
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/38-examing-modify-text2)

(defun get-this-tag (iter buffer)
  (let* ((start-tag (gtk:gtk-text-iter-copy iter))
         end-tag)
    (and (gtk:gtk-text-iter-find-char start-tag #'alpha-char-p)
         (setq end-tag (gtk:gtk-text-iter-copy start-tag))
         (gtk:gtk-text-iter-find-char end-tag
                                      (lambda (ch)
                                        (not (alphanumericp ch))))
         (gtk:gtk-text-buffer-get-text buffer start-tag end-tag nil))))

(defun closing-tag-p (iter)
  (let ((slash (gtk:gtk-text-iter-copy iter)))
    (gtk:gtk-text-iter-forward-char slash)
    (eql (gtk:gtk-text-iter-get-char slash) #\/)))

(defun main ()
  (gtk:within-main-loop
    (let ((window    (make-instance 'gtk:gtk-window
                                    :title "Multiline Editing Text"
                                    :type :toplevel
                                    :default-width 400
                                    :defalut-height 200))
          (text-view (make-instance 'gtk:gtk-text-view
                                    :hexpand t
                                    :vexpand t))
          (button    (make-instance 'gtk:gtk-button
                                    :label "Insert Close Tag"))
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

                                    (do ((stack '()))
                                        ((not (gtk:gtk-text-iter-find-char iter
                                                                           (lambda (ch) (eq ch #\<))
                                                                           :direction :backward)))
                                      (let ((tag (get-this-tag iter buffer)))
                                        (if (closing-tag-p iter)
                                            (push tag stack)
                                            (let ((tag-in-stack (pop stack)))
                                              (when (not tag-in-stack)
                                                (gtk:gtk-text-buffer-insert buffer
                                                                            (format nil "</~a>" tag))
                                                (return)))))))))
      
      (gtk:gtk-text-buffer-insert (gtk:gtk-text-view-buffer text-view)
                                  (format nil
                                          "<html>~%~
                                         <head><title>Title</title></head>~%~
                                         <body>~%~
                                         <h1>Heading</h1>~%"))
      
      (gtk:gtk-container-add vbox text-view)
      (gtk:gtk-container-add vbox button)

      ;; ボックスをウィンドウに追加
      (gtk:gtk-container-add window vbox)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
