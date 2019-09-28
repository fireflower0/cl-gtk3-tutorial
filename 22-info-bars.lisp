;; 22 情報バー

(defpackage #:cl-gtk3-tutorial/22-info-bars
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/22-info-bars)

;; メイン関数
(defun main ()
  (gtk:within-main-loop
    (let* ((window   (make-instance 'gtk:gtk-window
                                    :type  :toplevel
                                    :title "Info Bar"
                                    :border-width 12
                                    :default-width 250))
           (grid     (make-instance 'gtk:gtk-grid))
           (info-bar (make-instance 'gtk:gtk-info-bar
                                    :no-show-all t))
           (message  (make-instance 'gtk:gtk-label
                                    :label ""))
           (content  (gtk:gtk-info-bar-get-content-area info-bar)))
      
      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                ;; 終了処理 leave-gtk-main を呼び出す。
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      (gtk:gtk-widget-show message)

      ;; 情報バーのコンテンツ領域にラベルを追加する
      (gtk:gtk-container-add content message)

      ;; アクション領域にOKボタンを追加する
      (gtk:gtk-info-bar-add-button info-bar "gtk-ok" 1)

      ;; アクション領域にさらに2つのボタンを追加する
      (gtk:gtk-info-bar-add-buttons info-bar "gtk-cancel" 2 "gtk-no" 3)

      ;; 情報バーの"response"シグナル用のハンドラを接続する
      (gobject:g-signal-connect info-bar "response"
                                (lambda (widget response-id)
                                  (declare (ignore widget))
                                  (format t "response-id is ~A~%" response-id)
                                  (gtk:gtk-widget-hide info-bar)))
      
      (gtk:gtk-grid-attach grid info-bar 0 2 1 1)

      ;; 情報バーを表示する
      (gtk:gtk-label-set-text message "An Info Message in the content area.")
      (setf (gtk:gtk-info-bar-message-type info-bar) :info)
      (gtk:gtk-widget-show info-bar)
      
      ;; ボックスをウィンドウに置き、ウィンドウを表示する
      (gtk:gtk-container-add window grid)
      
      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
