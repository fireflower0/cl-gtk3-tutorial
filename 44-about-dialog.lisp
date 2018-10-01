;; 44 ダイアログ

;; ライブラリロード
(ql:quickload :cl-cffi-gtk)

(defun license-text ()
  (format nil
          "This program is free software: you can redistribute it and/or ~
          modify it under the terms of the GNU Lesser General Public ~
          License for Lisp as published by the Free Software Foundation, ~
          either version 3 of the License, or (at your option) any later ~
          version and with a preamble to the GNU Lesser General Public ~
          License that clarifies the terms for use with Lisp programs and ~
          is referred as the LLGPL.~%~% ~
          This program is distributed in the hope that it will be useful, ~
          but WITHOUT ANY WARRANTY; without even the implied warranty of ~
          MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the ~
          GNU Lesser General Public License for more details. ~%~% ~
          You should have received a copy of the GNU Lesser General Public ~
          License along with this program and the preamble to the Gnu ~
          Lesser General Public License.  If not, see ~
          <http://www.gnu.org/licenses/> and ~
          <http://opensource.franz.com/preamble.html>."))

(defun create-dialog ())

(defun create-message-dialog ())

(defun create-about-dialog ())

(defun main ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window
                                 :type :toplevel
                                 :title "Dialog"
                                 :default-width 250
                                 :border-width 12))
          (vbox   (make-instance 'gtk:gtk-vbox
                                 :spacing 6)))

      ;; destroy シグナルをラムダ関数と結びつける
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))

      ;; ビューをウィンドウに追加
      (gtk:gtk-container-add window vbox)

      (let ((button (make-instance 'gtk:gtk-button
                                   :label "Open a Dialog Window")))
        (gtk:gtk-box-pack-start vbox button)
        (gobject:g-signal-connect button "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    ;; ダイアログを作成して表示する
                                    (create-dialog))))

      (let ((button (make-instance 'gtk:gtk-button
                                   :label "Open a Message Dialog")))
        (gtk:gtk-box-pack-start vbox button)
        (gobject:g-signal-connect button "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    ;; メッセージダイアログを作成して表示する
                                    (create-message-dialog))))

      (let ((button (make-instance 'gtk:gtk-button
                                   :label "Open an About Dialog")))
        (gtk:gtk-box-pack-start vbox button)
        (gobject:g-signal-connect button "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    ;; ダイアログの作成と表示
                                    (create-about-dialog))))

      (gtk:gtk-box-pack-start vbox (make-instance 'gtk:gtk-hseparator))

      ;; 終了ボタンを作成する
      (let ((button (make-instance 'gtk:gtk-button
                                   :label "Quit")))
        (gobject:g-signal-connect button "clicked"
                                  (lambda (widget)
                                    (declare (ignore widget))
                                    (gtk:gtk-widget-destroy window)))
        (gtk:gtk-box-pack-start vbox button))
      
      ;; ウィジェット表示
      (gtk:gtk-widget-show-all window))))

;; main関数を呼び出して実行
(main)
