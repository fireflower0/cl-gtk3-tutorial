;; 34 タグの適用

(defpackage #:cl-gtk3-tutorial/34-applying-tags
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/34-applying-tags)

(defun on-button-clicked (buffer tag)
  (multiple-value-bind (start end)
      (gtk:gtk-text-buffer-get-selection-bounds buffer)
    (gtk:gtk-text-buffer-apply-tag-by-name buffer tag start end)))

(defun main ()
  (gtk:within-main-loop
    (let* ((window    (make-instance 'gtk:gtk-window
                                     :title "Multiline Text Input"
                                     :type :toplevel
                                     :default-width 300
                                     :default-height 200))
           (vbox      (make-instance 'gtk:gtk-grid
                                     :orientation :vertical))
           (bbox      (make-instance 'gtk:gtk-grid
                                     :orientation :horizontal))
           (text-view (make-instance 'gtk:gtk-text-view
                                     :hexpand t
                                     :vexpand t))
           (buffer    (gtk:gtk-text-view-buffer text-view)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      (gtk:gtk-container-add vbox bbox)
      (gtk:gtk-container-add vbox text-view)
      (gtk:gtk-text-buffer-insert buffer "Hello, world! Text view!")

      ;; バッファに関連付けられたタグを作成
      (gtk:gtk-text-tag-table-add (gtk:gtk-text-buffer-tag-table buffer)
                                  (make-instance 'gtk:gtk-text-tag
                                                 :name "bold"
                                                 :width 700))
      (gtk:gtk-text-tag-table-add (gtk:gtk-text-buffer-tag-table buffer)
                                  (make-instance 'gtk:gtk-text-tag
                                                 :name "italic"
                                                 :style :italic))
      (gtk:gtk-text-tag-table-add (gtk:gtk-text-buffer-tag-table buffer)
                                  (make-instance 'gtk:gtk-text-tag
                                                 :name "font"
                                                 :font "fixed"))

      ;; 太字ボタンを作成
      (let ((button (make-instance 'gtk:gtk-button :label "Bold")))
        (gobject:g-signal-connect button "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (on-button-clicked buffer "bold")))
        (gtk:gtk-container-add bbox button))

      ;; 斜体ボタンを作成
      (let ((button (make-instance 'gtk:gtk-button :label "Italic")))
        (gobject:g-signal-connect button "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (on-button-clicked buffer "italic")))
        (gtk:gtk-container-add bbox button))

      ;; 固定フォントボタンを作成
      (let ((button (make-instance 'gtk:gtk-button :label "Font Fixedx")))
        (gobject:g-signal-connect button "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (on-button-clicked buffer "font")))
        (gtk:gtk-container-add bbox button))

      ;; 閉じるボタンを作成
      (let ((button (make-instance 'gtk:gtk-button :label "Close")))
        (gobject:g-signal-connect button "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (gtk:gtk-widget-destroy window)))
        (gtk:gtk-container-add vbox button))

      ;; ボックスをウィンドウに追加
      (gtk:gtk-container-add window vbox)
      
      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
