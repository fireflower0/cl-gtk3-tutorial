;; 17 ラベル

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

;; ヘッダラベル
(defun make-heading (text)
  (make-instance 'gtk:gtk-label
                 :xalign 0
                 :use-markup t
                 :label (format nil "<b>~A</b>" text)))

;; メイン関数
(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :type  :toplevel
                                 :title "Labels"
                                 :default-width 250
                                 :border-width 12))
          (vbox1  (make-instance 'gtk:gtk-box
                                 :orientation :vertical
                                 :spacing 6))
          (vbox2  (make-instance 'gtk:gtk-box
                                 :orientation :vertical
                                 :spacing 6))
          (hbox   (make-instance 'gtk:gtk-box
                                 :orientation :horizontal
                                 :spacing 12)))
      
      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                ;; 終了処理 leave-gtk-main を呼び出す。
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; 標準ラベルを作成する
      (gtk:gtk-box-pack-start vbox1
                              (make-heading "Normal Label:")
                              :expand nil)
      (gtk:gtk-box-pack-start vbox1
                              (make-instance 'gtk:gtk-label
                                             :label "This is a Normal Label")
                              :expand nil)

      ;; 複数行ラベルを作成する
      (gtk:gtk-box-pack-start vbox1
                              (make-heading "Multi-line Label:")
                              :expand nil)
      (gtk:gtk-box-pack-start vbox1
                              (make-instance 'gtk:gtk-label
                                             :label (format nil "This is a Multi-line label~%~
                                                                Second line~%~
                                                                Third line"))
                              :expand nil)

      ;; 左揃えラベルを作成する
      (gtk:gtk-box-pack-start vbox1
                              (make-heading "Left Justified Label:")
                              :expand nil)
      (gtk:gtk-box-pack-start vbox1
                              (make-instance 'gtk:gtk-label
                                             :justify :left
                                             :label (format nil "This is a Left Justified~%~
                                                                Multi-line label~%~
                                                                Third line"))
                              :expand nil)

      ;; 右揃えラベルを作成する
      (gtk:gtk-box-pack-start vbox1
                              (make-heading "Right Justified Label:")
                              :expand nil)
      (gtk:gtk-box-pack-start vbox1
                              (make-instance 'gtk:gtk-label
                                             :justify :right
                                             :label (format nil "This is Right Justified~%~
                                                                 Multi-line label~%~
                                                                 Third line"))
                              :expand nil)

      ;; 行折り返しラベルを作成する
      (gtk:gtk-box-pack-start vbox2
                              (make-heading "Line Wrapped Label:")
                              :expand nil)
      (gtk:gtk-box-pack-start vbox2
                              (make-instance 'gtk:gtk-label
                                             :wrap t
                                             :label (format nil "This is a exapmle of a ~
                                                                 line-wrapped label. It should ~
                                                                 not be taking up the entire ~
                                                                 width allocated to it, but ~
                                                                 automatically wraps the words to ~
                                                                 fit. The time has come, for a ll ~
                                                                 good men, to come to the aid of ~
                                                                 their party. The sixth sheik's ~
                                                                 six sheep's sick. It supports ~
                                                                 multiple paragraphs correctly, ~
                                                                 and correctly adds many extra ~
                                                                 spaces."))
                              :expand nil)

      ;; 塗りつぶされラップされたラベルを作成する
      (gtk:gtk-box-pack-start vbox2
                              (make-heading "Filled and Wrapped Label:")
                              :expand nil)
      (gtk:gtk-box-pack-start vbox2
                              (make-instance 'gtk:gtk-label
                                             :wrap t
                                             :justify :fill
                                             :label (format nil "This is an example of a ~
                                                                 line-wrapped, filled label. It ~
                                                                 should be taking up the entire ~
                                                                 width allocated to it. Here is ~
                                                                 a sentence to prove my point. ~
                                                                 Here is another sentence. Here ~
                                                                 comes the sun, do de do de do. ~
                                                                 This is a new paragraph. This ~
                                                                 is another newer, longer, ~
                                                                 better paragraph. It is coming ~
                                                                 to an end, unfortunately."))
                              :expand nil)

      ;; 下線ラベルを作成する
      (gtk:gtk-box-pack-start vbox2
                              (make-heading "Underlined Label:")
                              :expand nil)
      (gtk:gtk-box-pack-start vbox2
                              (make-instance 'gtk:gtk-label
                                             :justify :left
                                             :use-underline t
                                             :pattern "_________________________ _ _________ _ __"
                                             :label (format nil "This label is underlined!~%~
                                                                 This one is underlined in quite ~
                                                                 a funky fashion"))
                              :expand nil)

      ;; ボックスをウィンドウに置き、ウィンドウを表示する
      (gtk:gtk-box-pack-start hbox vbox1 :expand nil)
      (gtk:gtk-box-pack-start hbox (gtk:gtk-separator-new :vertical))
      (gtk:gtk-box-pack-start hbox vbox2 :expand nil)
      (gtk:gtk-container-add window hbox)
      
      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
