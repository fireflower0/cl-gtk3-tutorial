;; 58 ツールバー

(defpackage #:cl-gtk3-tutorial/58-toolbars
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/58-toolbars)

(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :type :toplevel
                                 :default-width 250
                                 :default-height 150
                                 :title "Toolbar"))
          ;; メニューとボタンを配置するvbox
          (vbox   (gtk:gtk-box-new :vertical 0)))

      (let ((toolbar     (gtk:gtk-toolbar-new))
            (new-button  (gtk:gtk-tool-button-new-from-stock "gtk-new"))
            (open-button (gtk:gtk-tool-button-new-from-stock "gtk-open"))
            (save-button (gtk:gtk-tool-button-new-from-stock "gtk-save"))
            (quit-button (gtk:gtk-tool-button-new-from-stock "gtk-quit"))
            (separator   (make-instance 'gtk:gtk-separator-tool-item :draw nil)))

        (gtk:gtk-toolbar-insert toolbar new-button -1)
        (gtk:gtk-toolbar-insert toolbar open-button -1)
        (gtk:gtk-toolbar-insert toolbar save-button -1)
        (gtk:gtk-toolbar-insert toolbar separator -1)
        (gtk:gtk-toolbar-insert toolbar quit-button -1)
        (gtk:gtk-tool-item-set-expand separator t)
        (gtk:gtk-box-pack-start vbox toolbar :fill nil :expand nil :padding 3)

        ;; シグナルハンドラを終了ボタンに接続する
        (gobject:g-signal-connect quit-button "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (gtk:gtk-widget-destroy window))))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; ボックスをウィンドウに入れる
      (gtk:gtk-container-add window vbox)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
