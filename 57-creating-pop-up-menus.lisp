;; 57 ポップアップメニューの作成

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)


(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :type :toplevel
                                 :default-width 250
                                 :default-height 150
                                 :title "Popup Menu"))
          (button (gtk:gtk-button-new-with-label "Click me")))

      ;; ボタンのポップアップメニューを作成する
      (let ((popup-menu (gtk:gtk-menu-new))
            (big-item   (gtk:gtk-menu-item-new-with-label "Larger"))
            (small-item (gtk:gtk-menu-item-new-with-label "Smaller")))
        (gtk:gtk-menu-shell-append popup-menu big-item)
        (gtk:gtk-menu-shell-append popup-menu small-item)
        (gtk:gtk-widget-show-all popup-menu)

        ;; メニューをポップアップするシグナルハンドラ
        (gobject:g-signal-connect button "button-press-event"
                                  (lambda (widget event)
                                    (declare (ignore widget))
                                    (gtk:gtk-menu-popup popup-menu
                                                        :button (gdk:gdk-event-button-button event)
                                                        :activate-time (gdk:gdk-event-button-time event))
                                    t)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; ボタンをウィンドウに入れる
      (gtk:gtk-container-add window button)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
