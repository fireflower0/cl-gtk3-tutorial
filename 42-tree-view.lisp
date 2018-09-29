;; 42 ツリービュー

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defun create-and-fill-model ()
  (let ((model (make-instance 'gtk:gtk-list-store
                              :column-types '("gchararray" "guint"))))
    (gtk:gtk-list-store-set model (gtk:gtk-list-store-append model)
                            "FORTRAN" 1957)
    (gtk:gtk-list-store-set model (gtk:gtk-list-store-append model)
                            "LISP" 1958)
    (gtk:gtk-list-store-set model (gtk:gtk-list-store-append model)
                            "COBOL" 1959)
    model))

(defun create-view-and-model ()
  (let* ((model (create-and-fill-model))
         (view  (make-instance 'gtk:gtk-tree-view :model model)))
    ;; セルのレンダラーを作成
    (let* ((renderer (gtk:gtk-cell-renderer-text-new))
           (column   (gtk:gtk-tree-view-column-new-with-attributes "Language"
                                                                   renderer
                                                                   "text"
                                                                   0)))
      (gtk:gtk-tree-view-append-column view column))
    (let* ((renderer (gtk:gtk-cell-renderer-text-new))
           (column   (gtk:gtk-tree-view-column-new-with-attributes "Year"
                                                                   renderer
                                                                   "text"
                                                                   1)))
      (gtk:gtk-tree-view-append-column view column))
    view))

(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :title "Simple Tree View"
                                 :type :toplevel
                                 :border-width 12
                                 :default-width 300
                                 :default-height 200))
          (view   (create-view-and-model)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; ビューをウィンドウに追加
      (gtk:gtk-container-add window view)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
