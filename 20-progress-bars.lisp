;; 20 プログレスバー

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defstruct pbar-data
  pbar
  timer
  mode)

(defun progress-bar-timeout (pdata)
  (if (pbar-data-mode pdata)
      (gtk:gtk-progress-bar-pulse (pbar-data-pbar pdata))
      (let ((val (+ (gtk:gtk-progress-bar-fraction (pbar-data-pbar pdata)) 0.01)))
        (when (> val 1.0) (setq val 0.0))
        (setf (gtk:gtk-progress-bar-fraction (pbar-data-pbar pdata)) val)))
  t)

;; メイン関数
(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :type  :toplevel
                                 :title "Progress Bar"
                                 :default-width 300))
          (pdata  (make-pbar-data :pbar (make-instance 'gtk:gtk-progress-bar)))
          (vbox   (make-instance 'gtk:gtk-box
                                 :orientation :vertical
                                 :border-width 12
                                 :spacing 12))
          (align  (gtk:gtk-alignment-new 0.1 0.9 1.0 0.0))
          (table  (gtk:gtk-table-new 2 3 t)))

      (setf (pbar-data-timer pdata)
            (glib:g-timeout-add 100 (lambda () (progress-bar-timeout pdata))))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (glib:g-source-remove (pbar-data-timer pdata))
                                  (setf (pbar-data-timer pdata) 0)
                                  (gtk:leave-gtk-main)))
      
      (gtk:gtk-box-pack-start vbox align)
      (gtk:gtk-container-add align (pbar-data-pbar pdata))
      (gtk:gtk-box-pack-start vbox table)
      
      ;; テキスト表示用チェックボックス
      (let ((check (gtk:gtk-check-button-new-with-mnemonic "_Show text")))
        (gobject:g-signal-connect check "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (let ((text (gtk:gtk-progress-bar-text (pbar-data-pbar pdata))))
                                      (if (or (null text) (zerop (length text)))
                                          (setf (gtk:gtk-progress-bar-text (pbar-data-pbar pdata)) "Some text")
                                          (setf (gtk:gtk-progress-bar-text (pbar-data-pbar pdata)) ""))
                                      (setf (gtk:gtk-progress-bar-show-text (pbar-data-pbar pdata))
                                            (gtk:gtk-toggle-button-active check)))))
        (gtk:gtk-table-attach table check 0 1 0 1))

      ;; アクティビティモード用チェックボックス
      (let ((check (gtk:gtk-check-button-new-with-label "Activity mode")))
        (gobject:g-signal-connect check "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (setf (pbar-data-mode pdata) (not (pbar-data-mode pdata)))
                                    (if (pbar-data-mode pdata)
                                        (gtk:gtk-progress-bar-pulse (pbar-data-pbar pdata))
                                        (setf (gtk:gtk-progress-bar-fraction (pbar-data-pbar pdata)) 0.0))))
        (gtk:gtk-table-attach table check 0 1 1 2))

      ;; 反転用チェックボックス
      (let ((check (gtk:gtk-check-button-new-with-label "Inverted")))
        (gobject:g-signal-connect check "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (setf (gtk:gtk-progress-bar-inverted (pbar-data-pbar pdata))
                                          (gtk:gtk-toggle-button-active check))))
        (gtk:gtk-table-attach table check 0 1 2 3))
      
      ;; Closeボタン
      (let ((button (gtk:gtk-button-new-with-label "Close")))
        (gobject:g-signal-connect button "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (gtk:gtk-widget-destroy window)))
        (gtk:gtk-box-pack-start vbox button))
      
      ;; ボックスをウィンドウに置き、ウィンドウを表示する
      (gtk:gtk-container-add window vbox)
      
      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
