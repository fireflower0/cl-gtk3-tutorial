;; 46 カラーセレクタダイアログ

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defparameter *color* (gdk:gdk-rgba-parse "Blue"))

;; 4 rgbaカラーのカラーパレット
(defparameter *palette1* (list (gdk:gdk-rgba-parse "Red")
                               (gdk:gdk-rgba-parse "Yellow")
                               (gdk:gdk-rgba-parse "Blue")
                               (gdk:gdk-rgba-parse "Green")))

;; 3 rgbaグレーのグレーパレット
(defparameter *palette2* (list (gdk:gdk-rgba-parse "White")
                               (gdk:gdk-rgba-parse "Gray")
                               (gdk:gdk-rgba-parse "Black")))

(defun drawing-area-event (widget event area)
  (declare (ignore widget))
  (let ((handled nil))
    (when (eql (gdk:gdk-event-type event) :button-press)
      (let ((dialog (make-instance 'gtk:gtk-color-chooser-dialog
                                   :color *color*
                                   :use-alpha nil)))
        (setq handled t)

        ;; ダイアログにカスタムパレットを追加する
        (gtk:gtk-color-chooser-add-palette dialog :vertical 1 *palette1*)

        ;; 2番目のカスタムパレットをダイアログに追加する
        (gtk:gtk-color-chooser-add-palette dialog :vertical 1 *palette2*)

        ;; カラーチューザダイアログを実行する
        (let ((response (gtk:gtk-dialog-run dialog)))
          (when (eql response :ok)
            (setq *color* (gtk:gtk-color-chooser-get-rgba dialog)))
          ;; エリアウィジェットの色を設定する
          (gtk:gtk-widget-override-background-color area :normal *color*)
          ;; カラーチューザーダイアログを破棄する
          (gtk:gtk-widget-destroy dialog))))
    handled))

(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :title "Color Chooser Dialog"
                                 :default-width 300))
          (area   (make-instance 'gtk:gtk-drawing-area)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      (gtk:gtk-widget-override-background-color area :normal *color*)
      (setf (gtk:gtk-widget-events area) :button-press-mask)
      (gobject:g-signal-connect area "event"
                                (lambda (widget event)
                                  (drawing-area-event widget event area)))

      ;; エリアをウィンドウに追加
      (gtk:gtk-container-add window area)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)

