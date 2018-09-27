;; 41 ツールチップをテキストビューで表示

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defparameter *tooltip* nil)

(defun get-tip (word))

(defun tip-window-new (tip-text))

(defun insert-open-brace (window text-view location))

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
                                   (insert-open-brace window text-view location))
                                 (when (equal text ")")
                                   (when tooltip
                                     (gtk:gtk-widget-destroy tooltip)
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

;; main関数を呼び出して実行
(main)
