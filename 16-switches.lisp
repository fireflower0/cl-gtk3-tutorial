;; 16 スイッチ

(defpackage #:cl-gtk3-tutorial/16-switches
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/16-switches)

;; メイン関数
(defun main ()
  (gtk:within-main-loop
   (let ((window (make-instance 'gtk:gtk-window
                                :type  :toplevel
                                :title "Switch"
                                :default-width 230
                                :border-width 12))
         (switch (make-instance 'gtk:gtk-switch
                                :active t))
         (label  (make-instance 'gtk:gtk-label
                                :label "The Switch is ON"))
         (grid   (make-instance 'gtk:gtk-grid
                                :orientation :vertical
                                :row-spacing 6
                                :column-homogeneous t)))
     
     ;; destroy シグナルをラムダ関数と結びつける
     (gobject:g-signal-connect window "destroy"
                               ;; 終了処理 leave-gtk-main を呼び出す。
                               (lambda (widget)
                                 (declare (ignore widget))
                                 (gtk:leave-gtk-main)))

     (gobject:g-signal-connect switch "notify::active"
                               (lambda (widget param)
                                 (declare (ignore param))
                                 (if (gtk:gtk-switch-active widget)
                                     (setf (gtk:gtk-label-label label) "The Switch is ON")
                                     (setf (gtk:gtk-label-label label) "The Switch is OFF"))))

     (gtk:gtk-container-add grid   switch)
     (gtk:gtk-container-add grid   label)
     (gtk:gtk-container-add window grid)

     ;; ウィジェット表示
     (gtk:gtk-widget-show-all window))))
