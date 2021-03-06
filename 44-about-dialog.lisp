;; 44 ダイアログ

(defpackage #:cl-gtk3-tutorial/44-about-dialog
  (:use #:cl)
  (:export #:main))
(in-package #:cl-gtk3-tutorial/44-about-dialog)

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

(defun create-dialog ()
  (let ((dialog (make-instance 'gtk:gtk-dialog
                               :title "Dialog Window"
                               :has-separator t)))
    
    ;; コンテンツ領域のvboxにボーダー幅を追加する
    (setf (gtk:gtk-container-border-width (gtk:gtk-dialog-get-content-area dialog)) 12)
    
    ;; コンテンツエリアにテキスト付きのラベルウィジェットを追加する
    (let ((vbox  (make-instance 'gtk:gtk-vbox :border-width 12))
          (label (make-instance 'gtk:gtk-label
                                :wrap t
                                :label
                                (format nil
                                        "The content area is the place to ~
                                         put in the widgets.~%~% ~
                                         The action area is separated from ~
                                         the content area with a horizontal ~
                                         line."))))
      
      (gtk:gtk-box-pack-start vbox label)
      (gtk:gtk-box-pack-start (gtk:gtk-dialog-get-content-area dialog) vbox)

      ;; ダイアログのコンテンツ領域を表示する
      (gtk:gtk-widget-show-all (gtk:gtk-dialog-get-content-area dialog)))
    
    ;; ストックIDを持つボタンをアクション領域に追加する
    (gtk:gtk-dialog-add-button dialog "gtk-yes" :yes)
    (gtk:gtk-dialog-add-button dialog "gtk-no" :no)
    (gtk:gtk-dialog-add-button dialog "gtk-cancel" :cancel)
    (gtk:gtk-dialog-set-default-response dialog :cancel)
    
    ;; ボタンの順序を変更する
    (gtk:gtk-dialog-set-alternative-button-order dialog (list :yes :cancel :no))
    
    ;; ダイアログを実行し、コンソールにメッセージを表示する
    (format t "Response was: ~S~%" (gtk:gtk-dialog-run dialog))
    
    ;; ダイアログを破棄する
    (gtk:gtk-widget-destroy dialog)))

(defun create-message-dialog ()
  (let ((dialog (make-instance 'gtk:gtk-message-dialog
                               :message-type :info
                               :buttons :ok
                               :text "Info Message Dialog"
                               :secondary-text
                               (format nil
                                       "This is a message dialog of type ~
                                        :info with a secondary text."))))
    
    ;; メッセージダイアログを実行する
    (gtk:gtk-dialog-run dialog)
    
    ;; メッセージダイアログを破棄する
    (gtk:gtk-widget-destroy dialog)))

(defun create-about-dialog ()
  (let ((dialog (make-instance 'gtk:gtk-about-dialog
                               :program-name "Example Dialog"
                               :version "0.00"
                               :copyright "(c) Dieter Kaiser"
                               :website
                               "github.com/crategus/cl-cffi-gtk"
                               :website-label "Project web site"
                               :license (license-text)
                               :authors '("Kalyanov Dmitry"
                                          "Dieter Kaiser")
                               :documenters '("Dieter Kaiser")
                               :artists '("None")
                               :logo-icon-name
                               "applications-development"
                               :wrap-license t)))
    
    ;; aboutダイアログを実行する
    (gtk:gtk-dialog-run dialog)
    
    ;; ダイアログの破棄
    (gtk:gtk-widget-destroy dialog)))

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
