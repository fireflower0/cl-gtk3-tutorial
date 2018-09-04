;; 19 画像

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defparameter *load-timeout*  nil)
(defparameter *pixbuf-loader* nil)
(defparameter *image-stream*  nil)

(defun progressive-timeout (image)
  (if *image-stream*
      (let* ((buffer (make-array 512 :element-type '(unsigned-byte 8)))
             (len    (read-sequence buffer *image-stream*)))
        (if (= 0 len)
            ;; ファイルの最後に達しました。
            (progn
              (close *image-stream*)
              (setf *image-stream* nil)
              (gdk-pixbuf:gdk-pixbuf-loader-close *pixbuf-loader*)
              (setf *pixbuf-loader* nil)
              (return-from progressive-timeout glib:+g-source-remove+))
            ;; バッファをGdkPixbufLoaderにロードする
            (gdk-pixbuf:gdk-pixbuf-loader-write *pixbuf-loader* buffer 512)))
      (progn
        ;; イメージストリームとGdkPixbufLoaderを作成
        (setf *image-stream* (open "alphatest.png" :element-type '(unsigned-byte 8)))
        (when *pixbuf-loader*
          (gdk-pixbuf:gdk-pixbuf-loader-close *pixbuf-loader*)
          (setf *pixbuf-loader* nil))
        (setf *pixbuf-loader* (gdk-pixbuf:gdk-pixbuf-loader-new))
        (gobject:g-signal-connect *pixbuf-loader* "area-prepared"
                                  (lambda (loader)
                                    (let ((pixbuf (gdk-pixbuf:gdk-pixbuf-loader-get-pixbuf loader)))
                                      (gdk-pixbuf:gdk-pixbuf-fill pixbuf #xaaaaaaff)
                                      (gtk:gtk-image-set-from-pixbuf image pixbuf))))
        (gobject:g-signal-connect *pixbuf-loader* "area-updated"
                                  (lambda (loader x y width height)
                                    (declare (ignore loader x y width height))
                                    ;; GtkImageの内部のpixbufは変更されていますが、
                                    ;; 画像そのものは変更されていません。 再描画をキューに入れます。
                                    ;; 実際に効率的にしたい場合は、GtkImageの代わりに描画領域などを
                                    ;; 使うことができるので、画像上のPixbufの正確な位置を制御できる
                                    ;; ので、画像の更新された領域だけ描画をキューに入れることが
                                    ;; できます。
                                    (gtk:gtk-widget-queue-draw image)))))
  ;; GSourceを続行する
  glib:+g-source-continue+)

;; メイン関数
(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :type  :toplevel
                                 :title "Images"
                                 :border-width 12
                                 :default-width 300))
          (vgrid  (make-instance 'gtk:gtk-grid
                                 :orientation :vertical
                                 :border-width 8)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  ;; ロードタイムアウト元を破棄する
                                  (when *load-timeout*
                                    (glib:g-source-remove *load-timeout*)
                                    (setf *load-timeout* nil))
                                  ;; GdkPixbufLoaderオブジェクトを閉じる
                                  (when *pixbuf-loader*
                                    (gdk-pixbuf:gdk-pixbuf-loader-close *pixbuf-loader*)
                                    (setf *pixbuf-loader* nil))
                                  ;; 開いている入力ストリームを閉じる
                                  (when *image-stream*
                                    (close *image-stream*)
                                    (setf *image-stream* nil))
                                  ;; 終了処理 leave-gtk-main を呼び出す。
                                  (gtk:leave-gtk-main)))

      ;; ファイルから読み込まれた画像
      (let* ((label  (make-instance 'gtk:gtk-label
                                    :margin-bottom 3
                                    :use-markup t
                                    :label "<b>Image loaded from a file</b>"))
             (frame  (make-instance 'gtk:gtk-frame
                                    :shadow-type :in))
             (pixbuf (gdk-pixbuf:gdk-pixbuf-new-from-file "Material/pic/gtk-logo-old.png"))
             (image  (gtk:gtk-image-new-from-pixbuf pixbuf)))
        (gtk:gtk-container-add vgrid label)
        (gtk:gtk-container-add frame image)
        (gtk:gtk-container-add vgrid frame))

      ;; ファイルから読み込まれたアニメーション
      (let* ((label (make-instance 'gtk:gtk-label
                                   :margin-top 9
                                   :margin-bottom 6
                                   :use-markup t
                                   :label "<b>Animation loaded from a file</b>"))
             (frame (make-instance 'gtk:gtk-frame
                                   :shadow-type :in))
             (image (gtk:gtk-image-new-from-file "Material/pic/gtk-logo.gif")))
        (gtk:gtk-container-add vgrid label)
        (gtk:gtk-container-add frame image)
        (gtk:gtk-container-add vgrid frame))

      ;; 記号アイコン
      (let* ((label (make-instance 'gtk:gtk-label
                                   :margin-top 9
                                   :margin-bottom 6
                                   :use-markup t
                                   :label "<b>Symbolic themed icon</b>"))
             (frame (make-instance 'gtk:gtk-frame
                                   :shadow-type :in))
             (gicon (gio:g-themed-icon-new-with-default-fallbacks
                     "battery-caution-charging-symbolic"))
             (image (gtk:gtk-image-new-from-gicon gicon :dialog)))
        (gtk:gtk-container-add vgrid label)
        (gtk:gtk-container-add frame image)
        (gtk:gtk-container-add vgrid frame))

      ;; プログレッシブ

      ;; 感度制御
      (let ((button (make-instance 'gtk:gtk-toggle-button
                                   :margin-top 12
                                   :label "Insensitive")))
        (gobject:g-signal-connect button "toggled"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (let ((childs (gtk:gtk-container-get-children vgrid)))
                                      (dolist (child childs)
                                        (unless (gobject:g-type-is-a (gobject:g-object-type child)
                                                                     "GtkToggleButton")
                                          (if (gtk:gtk-toggle-button-active button)
                                              (progn
                                                (setf (gtk:gtk-widget-sensitive child) nil)
                                                (setf (gtk:gtk-button-label button) "Sensitive"))
                                              (progn
                                                (setf (gtk:gtk-widget-sensitive child) t)
                                                (setf (gtk:gtk-button-label button) "Insensitve"))))))))
        (gtk:gtk-container-add vgrid button))
      
      ;; ボックスをウィンドウに置き、ウィンドウを表示する
      (gtk:gtk-container-add window vgrid)
      
      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
