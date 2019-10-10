;; 39 画像挿入

(defpackage #:cl-gtk3-tutorial/39-insert-an-image
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/39-insert-an-image)

(defun main ()
  (gtk:within-main-loop
   (let ((window    (make-instance 'gtk:gtk-window
                                   :type :toplevel
                                   :title "Multiline Text Widget"
                                   :default-width 300
                                   :default-height 200))
         (text-view (make-instance 'gtk:gtk-text-view
                                   :hexpand t
                                   :vexpand t))
         (button    (make-instance 'gtk:gtk-button
                                   :label "Insert Image"))
         (vbox      (make-instance 'gtk:gtk-grid
                                   :orientation :vertical)))

     ;; destroy シグナルをラムダ関数と結びつける
     (gobject:g-signal-connect window "destroy"
                               (lambda (widget)
                                 (declare (ignore widget))
                                 (gtk:leave-gtk-main)))

     ;; 現在のカーソル位置に画像を挿入するシグナルハンドラ
     (gobject:g-signal-connect button "clicked"
                       (lambda (widget)
                         (declare (ignore widget))
                         (let* ((pixbuf (gdk-pixbuf:gdk-pixbuf-new-from-file "Material/icons/save.png"))
                                (buffer (gtk:gtk-text-view-buffer text-view))
                                (cursor (gtk:gtk-text-buffer-get-insert buffer))
                                (iter   (gtk:gtk-text-buffer-get-iter-at-mark buffer cursor)))
                           (gtk:gtk-text-buffer-insert-pixbuf buffer iter pixbuf))))
     
     (gtk:gtk-container-add vbox text-view)
     (gtk:gtk-container-add vbox button)

     ;; ボックスをウィンドウに追加
     (gtk:gtk-container-add window vbox)

     ;; ウィジェット表示
     (gtk:gtk-widget-show-all window))))
