;; 33 テキストビューのテキスト属性の変更

(defpackage #:cl-gtk3-tutorial/33-changing-text-attributes
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/33-changing-text-attributes)

(defun main ()
  (gtk:within-main-loop
    (let* ((window (make-instance 'gtk:gtk-window
                                  :type :toplevel
                                  :title "Text View"
                                  :default-width 350))
           (view   (make-instance 'gtk:gtk-text-view))
           (buffer (gtk:gtk-text-view-buffer view)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      (gtk:gtk-text-buffer-insert buffer "Hello, world!")

      ;; ウィジェット全体のデフォルトフォントを変更する
      (gtk:gtk-widget-override-font view
                                    (pango:pango-font-description-from-string "Serif 20"))

      ;; ウィジェット全体のデフォルトの色を変更する
      (gtk:gtk-widget-override-color view
                                     :normal (gdk:gdk-rgba-parse "red"))

      ;; ウィジェット全体の左マージンを変更する
      (gtk:gtk-text-view-set-left-margin view 30)

      ;; タグを使用してウィジェットの一部の色のみを変更する
      (let ((tag   (make-instance 'gtk:gtk-text-tag
                                  :name "blue_foreground"
                                  :foreground "blue"))
            (start (gtk:gtk-text-buffer-get-iter-at-offset buffer 7))
            (end   (gtk:gtk-text-buffer-get-iter-at-offset buffer 12)))
        ;; バッファのタグテーブルにタグを追加する
        (gtk:gtk-text-tag-table-add (gtk:gtk-text-buffer-tag-table buffer) tag)
        ;; バッファ内のテキストの領域にタグを適用する
        (gtk:gtk-text-buffer-apply-tag buffer tag start end))

      ;; ビューをウィンドウに追加
      (gtk:gtk-container-add window view)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
