;; 48 フォント選択ダイアログ

(defpackage #:cl-gtk3-tutorial/48-font-chooser-dialog
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/48-font-chooser-dialog)

(defun font-filter (family face)
  (declare (ignore face))
  (member (pango:pango-font-family-get-name family)
          '("Sans" "Serif")
          :test #'equal))

(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :title "Font Chooser Button"
                                 :type :toplevel
                                 :border-width 12
                                 :default-width 300
                                 :default-height 100))
          (button (make-instance 'gtk:gtk-font-button)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; フォントチューザーのフォントを選択するフィルター機能を設定する
      (gtk:gtk-font-chooser-set-filter-func button #'font-filter)
      (gobject:g-signal-connect button "font-set"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (format t "Font is set:~%")
                                  (format t "   Font name   : ~A~%"
                                          (gtk:gtk-font-chooser-font button))
                                  (format t "   Font family : ~A~%"
                                          (pango:pango-font-family-get-name
                                           (gtk:gtk-font-chooser-get-font-family button)))
                                  (format t "   Font face   : ~A~%"
                                          (pango:pango-font-face-get-face-name
                                           (gtk:gtk-font-chooser-get-font-face button)))
                                  (format t "   Font size   : ~A~%"
                                          (gtk:gtk-font-chooser-get-font-size button))))

      ;; ボタンをウィンドウに追加
      (gtk:gtk-container-add window button)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
