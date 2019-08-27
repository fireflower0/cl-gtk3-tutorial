(defsystem "cl-gtk3-tutorial"
    :class :package-inferred-system
    :version "0.1.0"
    :author "fireflower0"
    :license "MIT"
    :depends-on ("cl-cffi-gtk"
                 "cl-gtk3-tutorial/boot"))

(register-system-packages "cl-gtk3-tutorial/boot" '(#:cl-gtk3-tutorial))
