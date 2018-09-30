;; 43 永続的なセルレンダラーのプロパティ

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defun create-and-fill-model ()
  (let ((model (make-instance 'gtk:gtk-tree-store
                              :column-types '("gchararray" "gchararray"))))
    ;; 最上位の行を追加して空にします
    (gtk:gtk-tree-store-append model nil)
    ;; 2番目の最上位行を追加し、それに何らかのデータを入力します
    (let ((parent (gtk:gtk-tree-store-set model (gtk:gtk-tree-store-append model nil)
                                          "Joe" "Average")))
      ;; 2番目の最上位行に子を追加し、いくつかのデータを入力します。
      (gtk:gtk-tree-store-set model (gtk:gtk-tree-store-append model parent)
                              "Jane" "Average"))
    model))

(defun create-view-and-model ()
  (let* ((model (create-and-fill-model))
         (view  (make-instance 'gtk:gtk-tree-view
                               :model model)))
    ;; 最初の列を作成する
    (let* ((column (make-instance 'gtk:gtk-tree-view-column
                                  :title "First Name"))
           (renderer (make-instance 'gtk:gtk-cell-renderer-text
                                    :text "Booooo!")))
      ;; ツリービューに列をパックする
      (gtk:gtk-tree-view-append-column view column)
      ;; セルレンダラーをツリービュー列にパックする
      (gtk:gtk-tree-view-column-pack-start column renderer))

    ;; 2番目の列を作成する
    (let* ((column (make-instance 'gtk:gtk-tree-view-column
                                  :title "Last Name"))
           (renderer (make-instance 'gtk:gtk-cell-renderer-text
                                    :cell-background "Orange"
                                    :cell-background-set t)))
      ;; ツリービューに列をパックする
      (gtk:gtk-tree-view-append-column view column)
      ;; セルレンダラーをツリービュー列にパックする
      (gtk:gtk-tree-view-column-pack-start column renderer))
    ;; 選択不可
    (gtk:gtk-tree-selection-set-mode (gtk:gtk-tree-view-get-selection view) :none)
    view))

(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :title "Cell Renderer Properties"
                                 :type :toplevel
                                 :default-width 350
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
