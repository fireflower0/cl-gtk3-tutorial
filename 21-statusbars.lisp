;; 21 ステータスバー

(defpackage #:cl-gtk3-tutorial/21-statusbars
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/21-statusbars)

;; メイン関数
(defun main ()
  (gtk:within-main-loop
    (let* ((window    (make-instance 'gtk:gtk-window
                                     :type  :toplevel
                                     :title "Status Bar"
                                     :default-width 300
                                     :border-width 12))
           (vbox      (make-instance 'gtk:gtk-vbox
                                     :homogeneous nil
                                     :spacing 3))
           (statusbar (make-instance 'gtk:gtk-statusbar))
           (id        (gtk:gtk-statusbar-get-context-id statusbar "Status Bar"))
           (count     0))
      
      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                ;; 終了処理 leave-gtk-main を呼び出す。
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      (gtk:gtk-box-pack-start vbox statusbar)

      (let ((button (gtk:gtk-button-new-with-label "Push Item")))
        (gobject:g-signal-connect button "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (setq count (+ 1 count))
                                    (gtk:gtk-statusbar-push statusbar
                                                            id
                                                            (format nil "Item ~A" count))))
        (gtk:gtk-box-pack-start vbox button :expand t :fill t :padding 3))

      (let ((button (gtk:gtk-button-new-with-label "Pop Item")))
        (gobject:g-signal-connect button "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (gtk:gtk-statusbar-pop statusbar id)))
        (gtk:gtk-box-pack-start vbox button :expand t :fill t :padding 3))
      
      ;; ボックスをウィンドウに置き、ウィンドウを表示する
      (gtk:gtk-container-add window vbox)
      
      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
