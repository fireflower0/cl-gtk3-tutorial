;; 47 ファイル選択ダイアログ

(defpackage #:cl-gtk3-tutorial/47-file-chooser-dialog
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/47-file-chooser-dialog)

(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :title "File Chooser Dialog"
                                 :type :toplevel
                                 :border-width 12
                                 :default-width 300
                                 :default-height 100))
          (button (make-instance 'gtk:gtk-button
                                 :label "Select a file for save ..."
                                 :image
                                 (gtk:gtk-image-new-from-stock "gtk-save"
                                                               :button))))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; ボタンの"clicked"信号を処理します
      (gobject:g-signal-connect button "clicked"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (let ((dialog (gtk:gtk-file-chooser-dialog-new "Speichern"
                                                                                 nil
                                                                                 :save
                                                                                 "gtk-save" :accept
                                                                                 "gtk-cancel" :cancel)))
                                    (when (eq (gtk:gtk-dialog-run dialog) :accept)
                                      (format t "Saved to file ~A~%"
                                              (gtk:gtk-file-chooser-get-filename dialog)))
                                    (gtk:gtk-widget-destroy dialog))))
      
      ;; ボタンをウィンドウに追加
      (gtk:gtk-container-add window button)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
