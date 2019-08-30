;; 59 Demo Cairo Stroke

(defpackage #:cl-gtk3-tutorial/59-demo-cairo-stroke
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/59-demo-cairo-stroke)

(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :type :toplevel
                                 :title "Demo Cairo Stroke"
                                 :border-width 12
                                 :default-width 400
                                 :default-height 400)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; バッキング表面を扱うために使用される信号
      (gobject:g-signal-connect window "draw"
                                (lambda (widget cr)
                                  (let ((cr (gobject:pointer cr))
                                        ;; ウィジェットのGdkWindowを取得する
                                        (window (gtk:gtk-widget-window widget)))

                                    ;; surfaceクリア
                                    (cairo:cairo-set-source-rgb cr 1.0 1.0 1.0)
                                    (cairo:cairo-paint cr)

                                    ;; 1.0 x 1.0の座標空間での例
                                    (cairo:cairo-scale cr
                                                       (gdk:gdk-window-get-width  window)
                                                       (gdk:gdk-window-get-height window))

                                    ;; 描画コード
                                    (cairo:cairo-set-line-width cr 0.1)
                                    (cairo:cairo-set-source-rgb cr 1.0 0.0 0.0)
                                    (cairo:cairo-rectangle cr 0.25 0.25 0.5 0.5)
                                    (cairo:cairo-stroke cr)

                                    ;; Carioコンテキストを破棄
                                    (cairo:cairo-destroy cr)

                                    t)))

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
