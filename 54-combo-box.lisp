;; 54 コンボボックス

(defpackage #:cl-gtk3-tutorial/54-combo-box
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/54-combo-box)

(defun main ()
  (gtk:within-main-loop
    (let* ((window      (make-instance 'gtk:gtk-window
                                       :type :toplevel
                                       :border-width 12
                                       :title "Combo Box"))
           (model       (make-instance 'gtk:gtk-list-store
                                       :column-types '("gchararray" "gint")))
           (combo-box   (make-instance 'gtk:gtk-combo-box
                                       :model model))
           (title-label (make-instance 'gtk:gtk-label
                                       :label "Title:"))
           (value-label (make-instance 'gtk:gtk-label
                                       :label "Value:"))
           (title-entry (make-instance 'gtk:gtk-entry))
           (value-entry (make-instance 'gtk:gtk-entry))
           (button      (make-instance 'gtk:gtk-button
                                       :label "Add"))
           (table       (make-instance 'gtk:gtk-table
                                       :n-rows 3
                                       :n-columns 3)))

      ;; 列にデータを入力する
      (gtk:gtk-list-store-set model (gtk:gtk-list-store-append model) "Monday"    1)
      (gtk:gtk-list-store-set model (gtk:gtk-list-store-append model) "Tuesday"   2)
      (gtk:gtk-list-store-set model (gtk:gtk-list-store-append model) "Wednesday" 3)
      (gtk:gtk-list-store-set model (gtk:gtk-list-store-append model) "Thursday"  4)
      (gtk:gtk-list-store-set model (gtk:gtk-list-store-append model) "Friday"    5)
      (gtk:gtk-list-store-set model (gtk:gtk-list-store-append model) "Saturday"  6)
      (gtk:gtk-list-store-set model (gtk:gtk-list-store-append model) "Sunday"    7)

      ;; 最初のエントリをアクティブに設定する
      (gtk:gtk-combo-box-active combo-box)

      ;; シグナルハンドラを定義する
      (gobject:g-signal-connect window "destroy"
                                (lambda (w)
                                  (declare (ignore w))
                                  (gtk:leave-gtk-main)))

      (gobject:g-signal-connect button "clicked"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:gtk-list-store-set model
                                                          (gtk:gtk-list-store-append model)
                                                          (gtk:gtk-entry-text title-entry)
                                                          (or (parse-integer
                                                               (gtk:gtk-entry-text value-entry)
                                                               :junk-allowed t)
                                                              0))))

      (gobject:g-signal-connect combo-box "changed"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (let ((dialog (gtk:gtk-message-dialog-new
                                                 window
                                                 '(:destroy-with-parent)
                                                 :info
                                                 :close
                                                 "You selected row ~A"
                                                 (gtk:gtk-combo-box-active combo-box))))
                                    (gtk:gtk-dialog-run dialog)
                                    (gtk:gtk-widget-destroy dialog))))

      ;; セルのレンダラーを作成する
      (let ((renderer (make-instance 'gtk:gtk-cell-renderer-text
                                     :text "A text")))
        (gtk:gtk-cell-layout-pack-start    combo-box renderer :expand t)
        (gtk:gtk-cell-layout-add-attribute combo-box renderer "text" 0))

      (let ((renderer (make-instance 'gtk:gtk-cell-renderer-text
                                     :text "A number")))
        (gtk:gtk-cell-layout-pack-start    combo-box renderer :expand nil)
        (gtk:gtk-cell-layout-add-attribute combo-box renderer "text" 1))

      ;; ラベルを整列する
      (gtk:gtk-misc-set-alignment title-label 0.0 0.0)
      (gtk:gtk-misc-set-alignment value-label 0.0 0.0)

      ;; テーブルにウィジェットを入れる
      (gtk:gtk-table-attach table title-label 0 1 0 1)
      (gtk:gtk-table-attach table value-label 1 2 0 1)
      (gtk:gtk-table-attach table title-entry 0 1 1 2)
      (gtk:gtk-table-attach table value-entry 1 2 1 2)
      (gtk:gtk-table-attach table button      2 3 1 2)
      (gtk:gtk-table-attach table combo-box   0 3 2 3)

      ;; テーブルをウィンドウに入れる
      (gtk:gtk-container-add window table)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
