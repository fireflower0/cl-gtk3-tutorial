(defpackage #:cl-gtk3-tutorial
  (:use #:cl)
  (:import-from #:cl-gtk3-tutorial/01-simple-window)
  (:import-from #:cl-gtk3-tutorial/02-simple-window2)
  (:import-from #:cl-gtk3-tutorial/03-button)
  (:import-from #:cl-gtk3-tutorial/04-button2)
  (:import-from #:cl-gtk3-tutorial/05-button3)
  (:import-from #:cl-gtk3-tutorial/06-drawing)
  (:import-from #:cl-gtk3-tutorial/07-packing-boxes)
  (:import-from #:cl-gtk3-tutorial/08-table-packing)
  (:import-from #:cl-gtk3-tutorial/09-table-packing2)
  (:import-from #:cl-gtk3-tutorial/10-grid-packing)
  (:import-from #:cl-gtk3-tutorial/11-grid-packing2)
  (:import-from #:cl-gtk3-tutorial/12-normal-buttons)
  (:import-from #:cl-gtk3-tutorial/13-normal-buttons2)
  (:import-from #:cl-gtk3-tutorial/14-check-radio-button)
  (:import-from #:cl-gtk3-tutorial/15-link-buttons)
  (:import-from #:cl-gtk3-tutorial/16-switches)
  (:import-from #:cl-gtk3-tutorial/17-labels)
  (:import-from #:cl-gtk3-tutorial/18-labels2)
  (:import-from #:cl-gtk3-tutorial/19-images)
  (:import-from #:cl-gtk3-tutorial/20-progress-bars)
  (:import-from #:cl-gtk3-tutorial/21-statusbars)
  (:import-from #:cl-gtk3-tutorial/22-info-bars)
  ;; (:import-from #:cl-gtk3-tutorial/23-range-widgets)
  ;; (:import-from #:cl-gtk3-tutorial/24-alignment-widget)
  ;; (:import-from #:cl-gtk3-tutorial/25-fixed-container)
  ;; (:import-from #:cl-gtk3-tutorial/26-frames)
  ;; (:import-from #:cl-gtk3-tutorial/27-aspect-frame-container)
  ;; (:import-from #:cl-gtk3-tutorial/28-paned-window-widgets)
  ;; (:import-from #:cl-gtk3-tutorial/29-scrolled-windows)
  ;; (:import-from #:cl-gtk3-tutorial/30-button-boxes)
  ;; (:import-from #:cl-gtk3-tutorial/31-notebook)
  ;; (:import-from #:cl-gtk3-tutorial/32-multiline-text-widget)
  ;; (:import-from #:cl-gtk3-tutorial/33-changing-text-attributes)
  ;; (:import-from #:cl-gtk3-tutorial/34-applying-tags)
  ;; (:import-from #:cl-gtk3-tutorial/35-searching-text)
  ;; (:import-from #:cl-gtk3-tutorial/36-searching-text2)
  ;; (:import-from #:cl-gtk3-tutorial/37-examing-modify-text)
  ;; (:import-from #:cl-gtk3-tutorial/38-examing-modify-text2)
  ;; (:import-from #:cl-gtk3-tutorial/39-insert-an-image)
  ;; (:import-from #:cl-gtk3-tutorial/40-insert-a-widget)
  (:import-from #:cl-gtk3-tutorial/41-show-tooltips)
  ;; (:import-from #:cl-gtk3-tutorial/42-tree-view)
  ;; (:import-from #:cl-gtk3-tutorial/43-cell-renderer-property)
  ;; (:import-from #:cl-gtk3-tutorial/44-about-dialog)
  ;; (:import-from #:cl-gtk3-tutorial/45-color-button)
  ;; (:import-from #:cl-gtk3-tutorial/46-color-chooser-dialog)
  ;; (:import-from #:cl-gtk3-tutorial/47-file-chooser-dialog)
  ;; (:import-from #:cl-gtk3-tutorial/48-font-chooser-dialog)
  ;; (:import-from #:cl-gtk3-tutorial/49-buttons-with-arrows)
  ;; (:import-from #:cl-gtk3-tutorial/50-calendar)
  ;; (:import-from #:cl-gtk3-tutorial/51-event-box)
  ;; (:import-from #:cl-gtk3-tutorial/52-text-entry)
  ;; (:import-from #:cl-gtk3-tutorial/53-spin-buttons)
  ;; (:import-from #:cl-gtk3-tutorial/54-combo-box)
  ;; (:import-from #:cl-gtk3-tutorial/55-combo-box-text)
  (:import-from #:cl-gtk3-tutorial/56-creating-menus-by-hand)
  (:import-from #:cl-gtk3-tutorial/57-creating-pop-up-menus)
  (:import-from #:cl-gtk3-tutorial/58-toolbars)
  (:import-from #:cl-gtk3-tutorial/59-demo-cairo-stroke)
  (:import-from #:cl-gtk3-tutorial/60-demo-cairo-clock)
  (:export #:start))
(in-package #:cl-gtk3-tutorial)

(defun start (&key id)
  (case id
    (1 (cl-gtk3-tutorial/01-simple-window:main))
    (2 (cl-gtk3-tutorial/02-simple-window2:main))
    (3 (cl-gtk3-tutorial/03-button:main))
    (4 (cl-gtk3-tutorial/04-button2:main))
    (5 (cl-gtk3-tutorial/05-button3:main))
    (6 (cl-gtk3-tutorial/06-drawing:main))
    (7 (cl-gtk3-tutorial/07-packing-boxes:main 20)) ; 引数値は、ボタンの間隔
    (8 (cl-gtk3-tutorial/08-table-packing:main))
    (9 (cl-gtk3-tutorial/09-table-packing2:main))
    (10 (cl-gtk3-tutorial/10-grid-packing:main 20))
    (11 (cl-gtk3-tutorial/11-grid-packing2:main))
    (12 (cl-gtk3-tutorial/12-normal-buttons:main))
    (13 (cl-gtk3-tutorial/13-normal-buttons2:main))
    (14 (cl-gtk3-tutorial/14-check-radio-button:main))
    (15 (cl-gtk3-tutorial/15-link-buttons:main))
    (16 (cl-gtk3-tutorial/16-switches:main))
    (17 (cl-gtk3-tutorial/17-labels:main))
    (18 (cl-gtk3-tutorial/18-labels2:main))
    (19 (cl-gtk3-tutorial/19-images:main))
    (20 (cl-gtk3-tutorial/20-progress-bars:main))
    (21 (cl-gtk3-tutorial/21-statusbars:main))
    (22 (cl-gtk3-tutorial/22-info-bars:main))
    ;; (23 (cl-gtk3-tutorial/23-range-widgets:main))
    ;; (24 (cl-gtk3-tutorial/24-alignment-widget:main))
    ;; (25 (cl-gtk3-tutorial/25-fixed-container:main))
    ;; (26 (cl-gtk3-tutorial/26-frames:main))
    ;; (27 (cl-gtk3-tutorial/27-aspect-frame-container:main))
    ;; (28 (cl-gtk3-tutorial/28-paned-window-widgets:main))
    ;; (29 (cl-gtk3-tutorial/29-scrolled-windows:main))
    ;; (30 (cl-gtk3-tutorial/30-button-boxes:main))
    ;; (31 (cl-gtk3-tutorial/31-notebook:main))
    ;; (32 (cl-gtk3-tutorial/32-multiline-text-widget:main))
    ;; (33 (cl-gtk3-tutorial/33-changing-text-attributes:main))
    ;; (34 (cl-gtk3-tutorial/34-applying-tags:main))
    ;; (35 (cl-gtk3-tutorial/35-searching-text:main))
    ;; (36 (cl-gtk3-tutorial/36-searching-text2:main))
    ;; (37 (cl-gtk3-tutorial/37-examing-modify-text:main))
    ;; (38 (cl-gtk3-tutorial/38-examing-modify-text2:main))
    ;; (39 (cl-gtk3-tutorial/39-insert-an-image:main))
    ;; (40 (cl-gtk3-tutorial/40-insert-a-widget:main))
    (41 (cl-gtk3-tutorial/41-show-tooltips:main))
    ;; (42 (cl-gtk3-tutorial/42-tree-view:main))
    ;; (43 (cl-gtk3-tutorial/43-cell-renderer-property:main))
    ;; (44 (cl-gtk3-tutorial/44-about-dialog:main))
    ;; (45 (cl-gtk3-tutorial/45-color-button:main))
    ;; (46 (cl-gtk3-tutorial/46-color-chooser-dialog:main))
    ;; (47 (cl-gtk3-tutorial/47-file-chooser-dialog:main))
    ;; (48 (cl-gtk3-tutorial/48-font-chooser-dialog:main))
    ;; (49 (cl-gtk3-tutorial/49-buttons-with-arrows:main))
    ;; (50 (cl-gtk3-tutorial/50-calendar:main))
    ;; (51 (cl-gtk3-tutorial/51-event-box:main))
    ;; (52 (cl-gtk3-tutorial/52-text-entry:main))
    ;; (53 (cl-gtk3-tutorial/53-spin-buttons:main))
    ;; (54 (cl-gtk3-tutorial/54-combo-box:main))
    ;; (55 (cl-gtk3-tutorial/55-combo-box-text:main))
    (56 (cl-gtk3-tutorial/56-creating-menus-by-hand:main))
    (57 (cl-gtk3-tutorial/57-creating-pop-up-menus:main))
    (58 (cl-gtk3-tutorial/58-toolbars:main))
    (59 (cl-gtk3-tutorial/59-demo-cairo-stroke:main))
    (60 (cl-gtk3-tutorial/60-demo-cairo-clock:main))
    (t (format t "Hello, GTK3~%"))))
