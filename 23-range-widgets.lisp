;; 23 範囲ウィジェット

(defpackage #:cl-gtk3-tutorial/23-range-widgets
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/23-range-widgets)

;; メイン関数
(defun main ()
  (gtk:within-main-loop
    (let* ((window    (make-instance 'gtk:gtk-window
                                     :type :toplevel
                                     :title "Range Widgets"))
           (box1      (make-instance 'gtk:gtk-box
                                     :orientation :vertical
                                     :homogeneous nil
                                     :spacing 0))
           (box2      (make-instance 'gtk:gtk-box
                                     :orientation :horizontal
                                     :spacing 12
                                     :border-width 12))
           (box3      (make-instance 'gtk:gtk-box
                                     :orientation :vertical
                                     :homogeneous nil
                                     :spacing 12))
           (adj1      (make-instance 'gtk:gtk-adjustment
                                     :value 0.0
                                     :lower 0.0
                                     :upper 101.0
                                     :step-increment 0.1
                                     :page-increment 1.0
                                     :page-size 1.0))
           (vscale    (make-instance 'gtk:gtk-scale
                                     :orientation :vertical
                                     :digits 1
                                     :value-pos :top
                                     :draw-value t
                                     :adjustment adj1))
           (hscale    (make-instance 'gtk:gtk-scale
                                     :orientation :horizontal
                                     :digits 1
                                     :value-pos :top
                                     :draw-value t
                                     :width-request 200
                                     :height-request -1
                                     :adjustment adj1))
           (scrollbar (make-instance 'gtk:gtk-scrollbar
                                     :orientation :horizontal
                                     :adjustment adj1)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                ;; 終了処理 leave-gtk-main を呼び出す。
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; グローバルウィジェットhscale、vscale、およびscrollbarのパッキング
      (gtk:gtk-container-add window box1)
      (gtk:gtk-box-pack-start box1 box2)
      (gtk:gtk-box-pack-start box2 vscale)
      (gtk:gtk-box-pack-start box2 box3)
      (gtk:gtk-box-pack-start box3 hscale)
      (gtk:gtk-box-pack-start box3 scrollbar)

      ;; 値が表示されるかどうかを制御するチェックボタン
      (let ((box    (make-instance 'gtk:gtk-box
                                   :orientation :horizontal
                                   :homogeneous :nil
                                   :spacing 12
                                   :border-width 12))
            (button (make-instance 'gtk:gtk-check-button
                                   :label "Display value on scale widget"
                                   :active t)))
        (gobject:g-signal-connect button "toggled"
                                  (lambda (widget)
                                    (setf (gtk:gtk-scale-draw-value hscale)
                                          (gtk:gtk-toggle-button-active widget))
                                    (setf (gtk:gtk-scale-draw-value vscale)
                                          (gtk:gtk-toggle-button-active widget))))
        (gtk:gtk-box-pack-start box button)
        (gtk:gtk-box-pack-start box1 box))

      ;; ComboBoxを使用して値の位置を変更します
      (let ((box   (make-instance 'gtk:gtk-box
                                  :orientation :horizontal
                                  :homogeneous nil
                                  :spacing 12
                                  :border-width 12))
            (combo (make-instance 'gtk:gtk-combo-box-text))
            (iter  (make-instance 'gtk:gtk-tree-iter)))
        (gtk:gtk-combo-box-text-append-text combo "TOP")
        (gtk:gtk-combo-box-text-append-text combo "BOTTOM")
        (gtk:gtk-combo-box-text-append-text combo "LEFT")
        (gtk:gtk-combo-box-text-append-text combo "RIGHT")
        (gtk:gtk-combo-box-set-active-iter combo iter)
        (gobject:g-signal-connect combo "changed"
                                  (lambda (widget)
                                    (let ((pos (gtk:gtk-combo-box-text-get-active-text widget)))
                                      (format t "type      : ~A~%"
                                              (gobject:g-type-from-instance (gobject:pointer widget)))
                                      (format t "active is : ~A~%"
                                              (gtk:gtk-combo-box-get-active-iter widget))
                                      (setq pos (if pos (intern pos :keyword) :top))
                                      (setf (gtk:gtk-scale-value-pos hscale) pos)
                                      (setf (gtk:gtk-scale-value-pos vscale) pos))))
        (gtk:gtk-box-pack-start box1
                                (make-instance 'gtk:gtk-label :label "Scale value position")
                                :expand nil :fill nil :padding 0)
        (gtk:gtk-box-pack-start box combo)
        (gtk:gtk-box-pack-start box1 box))

      ;; hscaleとvscaleの桁を変更する尺度を作成します
      (let* ((box   (make-instance 'gtk:gtk-box
                                   :orientation :horizontal
                                   :homogeneous nil
                                   :spacing 12
                                   :border-width 12))
             (adj   (make-instance 'gtk:gtk-adjustment
                                   :value 1.0
                                   :lower 0.0
                                   :upper 5.0
                                   :step-increment 1.0
                                   :page-increment 1.0
                                   :page-size 0.0))
             (scale (make-instance 'gtk:gtk-scale
                                   :orientation :horizontal
                                   :digits 0
                                   :adjustment adj)))
        (gobject:g-signal-connect adj "value-changed"
                                  (lambda (adjustment)
                                    (setf (gtk:gtk-scale-digits hscale)
                                          (truncate (gtk:gtk-adjustment-value adjustment)))
                                    (setf (gtk:gtk-scale-digits vscale)
                                          (truncate (gtk:gtk-adjustment-value adjustment)))))
        (gtk:gtk-box-pack-start box
                                (make-instance 'gtk:gtk-label :label "Scale Digits:")
                                :expand nil :fill nil)
        (gtk:gtk-box-pack-start box scale)
        (gtk:gtk-box-pack-start box1 box))

      ;; スクロールバーのページサイズを調整する別のhscale
      (let* ((box   (make-instance 'gtk:gtk-box
                                   :orientation :horizontal
                                   :homogeneous nil
                                   :spacing 12
                                   :border-width 12))
             (adj   (make-instance 'gtk:gtk-adjustment
                                   :value 1.0
                                   :lower 1.0
                                   :upper 101.0
                                   :step-increment 1.0
                                   :page-increment 1.0
                                   :page-size 0.0))
             (scale (make-instance 'gtk:gtk-scale
                                   :orientation :horizontal
                                   :digits 0
                                   :adjustment adj)))
        (gobject:g-signal-connect adj "value-changed"
                                  (lambda (adjustment)
                                    (setf (gtk:gtk-adjustment-page-size adj1)
                                          (gtk:gtk-adjustment-page-size adjustment))
                                    (setf (gtk:gtk-adjustment-page-increment adj1)
                                          (gtk:gtk-adjustment-page-increment adjustment))))
        (gtk:gtk-box-pack-start box
                                (make-instance 'gtk:gtk-label :label "Scrollbar Page Size:")
                                :expand nil :fill nil)
        (gtk:gtk-box-pack-start box scale)
        (gtk:gtk-box-pack-start box1 box))

      ;; セパレータを追加する
      (gtk:gtk-box-pack-start box1 (make-instance 'gtk:gtk-separator
                                                  :orientation :horizontal)
                              :expand nil :fill t)

      ;; 終了ボタンを作成します
      (let ((box    (make-instance 'gtk:gtk-box
                                   :orientation :vertical
                                   :homogeneous nil
                                   :spacing 12
                                   :border-width 12))
            (button (make-instance 'gtk:gtk-button
                                   :label "Quit")))
        (gobject:g-signal-connect button "clicked"
                                  (lambda (button)
                                    (declare (ignore button))
                                    (gtk:gtk-widget-destroy window)))
        (gtk:gtk-box-pack-start box button)
        (gtk:gtk-box-pack-start box1 box :expand nil))
      
      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
