;; 53 スピンボタン

(defpackage #:cl-gtk3-tutorial/53-spin-buttons
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/53-spin-buttons)

(defun main ()
  (gtk:within-main-loop
    (let* ((window (make-instance 'gtk:gtk-window
                                  :type :toplevel
                                  :title "Spin Button"
                                  :default-width 300))
           (vbox   (make-instance 'gtk:gtk-vbox
                                  :homogeneous nil
                                  :spacing 6
                                  :border-width 12))
           (vbox1  (make-instance 'gtk:gtk-vbox
                                  :homogeneous nil
                                  :spacing 0
                                  :border-width 6))
           (vbox2  (make-instance 'gtk:gtk-vbox
                                  :homogeneous nil
                                  :spacing 0
                                  :boder-width 6))
           (hbox   (make-instance 'gtk:gtk-hbox))
           (frame1 (make-instance 'gtk:gtk-frame
                                  :label "Not accelerated"))
           (frame2 (make-instance 'gtk:gtk-frame
                                  :label "Accelerated"))
           (label  (make-instance 'gtk:gtk-label
                                  :label "0")))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; スピンボタン(日)
      (let ((vbox    (make-instance 'gtk:gtk-vbox))
            (spinner (make-instance 'gtk:gtk-spin-button
                                    :adjustment (make-instance 'gtk:gtk-adjustment
                                                               :value 1.0
                                                               :lower 1.0
                                                               :upper 31.0
                                                               :step-increment 1.0
                                                               :page-increment 5.0
                                                               :page-size 0.0)
                                    :climb-rate 0
                                    :digits 0
                                    :wrap t)))

        (gtk:gtk-box-pack-start vbox (make-instance 'gtk:gtk-label
                                                    :label "Day :"
                                                    :xalign 0
                                                    :yalign 0.5)
                                :expand nil)

        (gtk:gtk-box-pack-start vbox spinner :expand nil)
        (gtk:gtk-box-pack-start hbox vbox :padding 6))

      ;; スピンボタン(月)
      (let ((vbox    (make-instance 'gtk:gtk-vbox))
            (spinner (make-instance 'gtk:gtk-spin-button
                                    :adjustment (make-instance 'gtk:gtk-adjustment
                                                               :value 1.0
                                                               :lower 1.0
                                                               :upper 12.0
                                                               :step-increment 1.0
                                                               :page-increment 5.0
                                                               :page-size 0.0)
                                    :climb-rate 0
                                    :digits 0
                                    :wrap t)))

        (gtk:gtk-box-pack-start vbox (make-instance 'gtk:gtk-label
                                                    :label "Month :"
                                                    :xalign 0
                                                    :yalign 0.5)
                                :expand nil)

        (gtk:gtk-box-pack-start vbox spinner :expand nil)
        (gtk:gtk-box-pack-start hbox vbox :padding 6))

      ;; スピンボタン(年)
      (let ((vbox    (make-instance 'gtk:gtk-vbox))
            (spinner (make-instance 'gtk:gtk-spin-button
                                    :adjustment (make-instance 'gtk:gtk-adjustment
                                                               :value 1.0
                                                               :lower 1998.0
                                                               :upper 2100.0
                                                               :step-increment 1.0
                                                               :page-increment 100.0
                                                               :page-size 0.0)
                                    :climb-rate 0
                                    :digits 0
                                    :wrap t)))

        (gtk:gtk-box-pack-start vbox (make-instance 'gtk:gtk-label
                                                    :label "Year :"
                                                    :xalign 0
                                                    :yalign 0.5)
                                :expand nil)

        (gtk:gtk-box-pack-start vbox spinner :expand nil :fill t)
        (gtk:gtk-box-pack-start hbox vbox :padding 6))

      (gtk:gtk-box-pack-start vbox1 hbox :padding 6)
      (gtk:gtk-container-add frame1 vbox1)
      (gtk:gtk-box-pack-start vbox frame1)

      (setq hbox (make-instance 'gtk:gtk-hbox))

      (let ((vbox (make-instance 'gtk:gtk-vbox))
            (spinner1 (make-instance 'gtk:gtk-spin-button
                                     :adjustment (make-instance 'gtk:gtk-adjustment
                                                                :value 1.0
                                                                :lower -10000.0
                                                                :upper  10000.0
                                                                :step-increment 0.5
                                                                :page-increment 100.0
                                                                :page-size 0.0)
                                     :climb-rate 1.0
                                     :digits 2
                                     :wrap t))
            (spinner2 (make-instance 'gtk:gtk-spin-button
                                     :adjustment (make-instance 'gtk:gtk-adjustment
                                                                :value 2
                                                                :lower 1
                                                                :upper 5
                                                                :step-increment 1
                                                                :page-increment 1
                                                                :page-size 0)
                                     :climb-rate 0.0
                                     :digits 0
                                     :wrap t)))

        ;; スピンボタン(値)
        (gtk:gtk-box-pack-start vbox (make-instance 'gtk:gtk-label
                                                    :label "Value :"
                                                    :xalign 0
                                                    :yalign 0.5)
                                :fill t)
        (gtk:gtk-box-pack-start vbox spinner1 :expand nil)
        (gtk:gtk-box-pack-start hbox vbox :padding 6)

        (gobject:g-signal-connect spinner2 "value-changed"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    ;; (gtk:gtk-spin-button-set-digits
                                    ;;  spinner1
                                    ;;  (gtk:gtk-spin-button-get-value-as-int spinner2))
                                    ))

        (setq vbox (make-instance 'gtk:gtk-vbox))
        (gtk:gtk-box-pack-start vbox (make-instance 'gtk:gtk-label
                                                    :label "Digits :"
                                                    :xalign 0
                                                    :yalign 0.5)
                                :expand nil)

        (gtk:gtk-box-pack-start vbox spinner2 :expand nil)
        (gtk:gtk-box-pack-start hbox vbox :padding 6)
        (gtk:gtk-box-pack-start vbox2 hbox :padding 6)

        ;; 0.5刻みにスナップ
        (let ((check (make-instance 'gtk:gtk-check-button
                                    :label "Snap to 0.5-ticks"
                                    :active t)))
          (gobject:g-signal-connect check "clicked"
                                    (lambda (widget)
                                      (declare (ignore widget))
                                      ;; (gtk:gtk-spin-button-set-snap-to-ticks
                                      ;;  spinner1
                                      ;;  (gtk:gtk-toggle-button-active widget))
                                      ))
          (gtk:gtk-box-pack-start vbox2 check))

        ;; 数値入力モード
        (let ((check (make-instance 'gtk:gtk-check-button
                                    :label "Numeric only input mode"
                                    :active t)))
          (gobject:g-signal-connect check "clicked"
                                    (lambda (widget)
                                      (declare (ignore widget))
                                      ;; (gtk:gtk-spin-button-set-numeric
                                      ;;  spinner1
                                      ;;  (gtk:gtk-toggle-button-active widget))
                                      ))
          (gtk:gtk-box-pack-start vbox2 check))

        (gtk:gtk-container-add frame2 vbox2)
        (setq hbox (make-instance 'gtk:gtk-hbox))

        (let ((button (gtk:gtk-button-new-with-label "Value as Int")))
          (gobject:g-signal-connect button "clicked"
                                    (lambda (widget)
                                      (declare (ignore widget))
                                      (gtk:gtk-label-set-text
                                       label
                                       (format nil "~A"
                                               (gtk:gtk-spin-button-get-value-as-int
                                                spinner1)))))
          (gtk:gtk-box-pack-start hbox button))

        (let ((button (gtk:gtk-button-new-with-label "Value as Float")))
          (gobject:g-signal-connect button "clicked"
                                    (lambda (widget)
                                      (declare (ignore widget))
                                      (gtk:gtk-label-set-text
                                       label
                                       (format nil "~A"
                                               (gtk:gtk-spin-button-value spinner1)))))
          (gtk:gtk-box-pack-start hbox button))

        (gtk:gtk-box-pack-start vbox2 hbox)
        (gtk:gtk-box-pack-start vbox2 label))

      (gtk:gtk-box-pack-start vbox frame2)

      (let ((button (make-instance 'gtk:gtk-button
                                   :label "Close")))
        (gobject:g-signal-connect button "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (gtk:gtk-widget-destroy window)))
        (gtk:gtk-box-pack-start vbox button))

      ;; ボックスをウィンドウに追加
      (gtk:gtk-container-add window vbox)
      
      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))
