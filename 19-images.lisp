;; 19 画像

(defpackage #:cl-gtk3-tutorial/19-images
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/19-images)

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
        (setf *image-stream* (open "Material/pic/alphatest.png" :element-type '(unsigned-byte 8)))
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
      (let* ((label     (make-instance 'gtk:gtk-label
                                       :margin-top 9
                                       :margin-bottom 6
                                       :use-markup t
                                       :label "<b>Progressive image loading</b>"))
             (frame     (make-instance 'gtk:gtk-frame
                                       :shadow-type :in))
             (event-box (make-instance 'gtk:gtk-event-box))
             (image     (gtk:gtk-image-new-from-pixbuf nil)))

        (setf *load-timeout*
              (gdk:gdk-threads-add-timeout 100
                                           (lambda ()
                                             (progressive-timeout image))))

        ;; ファイルからのイメージの読み込みを再開する
        (gobject:g-signal-connect event-box "button-press-event"
                                  (lambda (event-box event)
                                    (format t "Event Box ~A clicked at (~A, ~A)~%"
                                            event-box
                                            (gdk:gdk-event-button-x event)
                                            (gdk:gdk-event-button-y event))
                                    (setf *load-timeout*
                                          (gdk:gdk-threads-add-timeout 100
                                                                       (lambda ()
                                                                         (progressive-timeout image))))))
        (gtk:gtk-container-add vgrid label)
        (gtk:gtk-container-add event-box image)
        (gtk:gtk-container-add frame event-box)
        (gtk:gtk-container-add vgrid frame))

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
