;; 41 ツールチップをテキストビューで表示

(defpackage #:cl-gtk3-tutorial/41-show-tooltips
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/41-show-tooltips)


(defparameter *tooltip* nil)

(defun get-tip (word)
  (cdr (assoc word
              '(("printf"  . "(const char *format, ...)")
                ("fprintf" . "(FILE *stream, const char *format, ...)")
                ("sprintf" . "(char *str, const char *format, ...)")
                ("fputc"   . "(int c, FILE *stream)")
                ("fputs"   . "(const char *s, FILE *stream)")
                ("putc"    . "(int c, FILE *stream)")
                ("putchar" . "(int c)")
                ("puts"    . "(const char *s)"))
              :test #'equal)))

(defun tip-window-new (tip-text)
  (let ((win       (make-instance 'gtk:gtk-window
                                  :type :popup
                                  :border-width 0))
        (event-box (make-instance 'gtk:gtk-event-box
                                  :border-width 1))
        (label     (make-instance 'gtk:gtk-label
                                  :label tip-text)))
    (gtk:gtk-widget-override-font label (pango:pango-font-description-from-string "Courier"))
    (gtk:gtk-widget-override-background-color win :normal (gdk:gdk-rgba-parse "Gray"))
    (gtk:gtk-widget-override-color win :normal (gdk:gdk-rgba-parse "Blue"))
    (gtk:gtk-container-add event-box label)
    (gtk:gtk-container-add win event-box)
    win))

(defun insert-open-brace (text-view location)
  (let ((start (gtk:gtk-text-iter-copy location)))
    (when (gtk:gtk-text-iter-backward-word-start start)
      (let* ((word     (string-trim " " (gtk:gtk-text-iter-get-text start location)))
             (tip-text (get-tip word)))
        (when tip-text
          (let ((rect (gtk:gtk-text-view-get-iter-location text-view location))
                (win  (gtk:gtk-text-view-get-window text-view :widget)))
            (multiple-value-bind (win-x win-y)
                (gtk:gtk-text-view-buffer-to-window-coords text-view
                                                           :widget
                                                           (gdk:gdk-rectangle-x rect)
                                                           (gdk:gdk-rectangle-y rect))
              (multiple-value-bind (x y)
                  (gdk:gdk-window-get-origin win)
                ;; 以前のツールチップウィンドウを破棄する
                (when *tooltip*
                  (gtk:gtk-widget-destroy *tooltip*)
                  (setf *tooltip* nil))
                ;; 新しいツールチップウィンドウを作成する
                (setf *tooltip* (tip-window-new tip-text))
                ;; 計算された位置に置きます
                (gtk:gtk-window-move *tooltip*
                                     (+ win-x x)
                                     (+ win-y y (gdk:gdk-rectangle-height rect)))
                (gtk:gtk-widget-show-all *tooltip*)))))))))

(defun main ()
  (gtk:within-main-loop
   (let* ((window    (make-instance 'gtk:gtk-window
                                    :title "Multiline Text Search"
                                    :type :toplevel
                                    :default-width 450
                                    :default-height 200))
          (scrolled  (make-instance 'gtk:gtk-scrolled-window))
          (text-view (make-instance 'gtk:gtk-text-view
                                    :hexpand t
                                    :vexpand t))
          (buffer    (gtk:gtk-text-view-buffer text-view)))

     ;; destroy シグナルをラムダ関数と結びつける
     (gobject:g-signal-connect window "destroy"
                               (lambda (widget)
                                 (declare (ignore widget))
                                 (when *tooltip*
                                   (gtk:gtk-widget-destroy *tooltip*)
                                   (setf *tooltip* nil))
                                 (gtk:leave-gtk-main)))

     ;; テキストビューのバッファ用のシグナルハンドラ
     (gobject:g-signal-connect buffer "insert-text"
                               (lambda (buffer location text len)
                                 (declare (ignore buffer len))
                                 (when (equal text "(")
                                   (insert-open-brace text-view location))
                                 (when (equal text ")")
                                   (when *tooltip*
                                     (gtk:gtk-widget-destroy *tooltip*)
                                     (setf *tooltip* nil)))))

     ;; デフォルトのフォントを変更する
     (gtk:gtk-widget-override-font
      text-view
      (pango:pango-font-description-from-string "Courier 12"))

     ;;ウィジェットをウィンドウに追加してすべて表示
     (gtk:gtk-container-add scrolled text-view)
     (gtk:gtk-container-add window scrolled)

     ;; ウィジェット表示
     (gtk:gtk-widget-show-all window))))
