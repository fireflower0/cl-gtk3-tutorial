;; 10 グリッドを使用したパッキング

(defpackage #:cl-gtk3-tutorial/10-grid-packing
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/10-grid-packing)

;; 
(defun make-grid (homogeneous spacing expand align margin)
  (let ((box (make-instance 'gtk:gtk-grid
                            :orientation :horizontal
                            :column-homogeneous homogeneous
                            :column-spacing spacing)))
    (gtk:gtk-container-add box (make-instance 'gtk:gtk-button
                                              :label "gtk-container-add"
                                              :hexpand expand
                                              :halgin align
                                              :margin margin))
    (gtk:gtk-container-add box (make-instance 'gtk:gtk-button
                                              :label "box"
                                              :hexpand expand
                                              :halign align
                                              :margin margin))
    (gtk:gtk-container-add box (make-instance 'gtk:gtk-button
                                              :label "button"
                                              :hexpand expand
                                              :halign align
                                              :margin margin))
    (gtk:gtk-container-add box (make-instance 'gtk:gtk-button
                                              :label (if expand "T" "NIL")
                                              :hexpand expand
                                              :halign align
                                              :margin margin))
    (gtk:gtk-container-add box (make-instance 'gtk:gtk-button
                                              :label (format nil "~A" align)
                                              :hexpand expand
                                              :halign align
                                              :margin margin))
    (gtk:gtk-container-add box (make-instance 'gtk:gtk-button
                                              :label (format nil "~A" margin)
                                              :hexpand expand
                                              :halign align
                                              :margin margin))
    box))

;; メイン関数
(defun main (&optional (spacing 0))
  (gtk:within-main-loop
    (let (;; タイトルとデフォルトの幅・高さを持つトップレベルウィンドウを作成
          (window  (make-instance 'gtk:gtk-window
                                  :title "Grid Packing"
                                  :type :toplevel
                                  :border-width 12
                                  :default-height 200
                                  :default-width 300))
          (vbox    (make-instance 'gtk:gtk-grid
                                  :orientation :vertical
                                  :row-spacing 6))
          (button  (make-instance 'gtk:gtk-button
                                  :label "Quit"))
          (quitbox (make-instance 'gtk:gtk-box
                                  :orientation :horizontal)))

      ;; clicked シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect button "clicked"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:gtk-widget-destroy window)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; ウィジェットをウィンドウに配置
      (gtk:gtk-container-add vbox (make-instance 'gtk:gtk-label
                                                 :label (format nil
                                                                "GtkGrid homogeneous nil spacing ~A"
                                                                spacing)
                                                 :xalign 0
                                                 :yalign 0
                                                 :vexpand nil
                                                 :valign :start))
      (gtk:gtk-container-add vbox (gtk:gtk-separator-new :horizontal))
      (gtk:gtk-container-add vbox (make-grid nil spacing nil :center 0))
      (gtk:gtk-container-add vbox (make-grid nil spacing t   :center 0))
      (gtk:gtk-container-add vbox (make-grid nil spacing t   :fill 0))
      (gtk:gtk-container-add vbox (gtk:gtk-separator-new :horizontal))
      (gtk:gtk-container-add vbox (make-instance 'gtk:gtk-label
                                                 :label (format nil
                                                                "GtkGrid homogeneous t spacing ~A"
                                                                spacing)
                                                 :xalign 0
                                                 :yalign 0
                                                 :vexpand nil
                                                 :valign :start
                                                 :margin 6))
      (gtk:gtk-container-add vbox (gtk:gtk-separator-new :horizontal))
      (gtk:gtk-container-add vbox (make-grid t spacing t :center 0))
      (gtk:gtk-container-add vbox (make-grid t spacing t :fill 0))
      (gtk:gtk-container-add vbox (gtk:gtk-separator-new :horizontal))
      (gtk:gtk-container-add quitbox button)
      (gtk:gtk-container-add vbox quitbox)
      (gtk:gtk-container-add window vbox)

      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
