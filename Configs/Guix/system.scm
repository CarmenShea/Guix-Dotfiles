;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu) (nongnu packages linux) (gnu packages lisp))

(use-service-modules cups desktop networking ssh xorg)
(use-package-modules wm)
(use-package-modules fonts wm)

(operating-system
 (kernel linux)
 (firmware (list linux-firmware))
  (locale "en_US.utf8")
  (timezone "America/Edmonton")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "guix")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "carmen")
                  (comment "Carmen")
                  (group "users")
                  (home-directory "/home/carmen")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list (specification->package "emacs")
                          (specification->package "emacs-exwm")
                          (specification->package
                           "emacs-desktop-environment")
                          (specification->package "nss-certs"))
  ;;                  %base-packages))
                     (list sbcl stumpwm `(,stumpwm "lib"))
  ;;                       %base-packages))
                     (list sbcl stumpwm `(,stumpwm "lib"))
  ;;                  sbcl-ttf-fonts font-dejavu
		    %base-packages))



  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list (service xfce-desktop-service-type)
                 (service mate-desktop-service-type)
                 (service cups-service-type)
                 (set-xorg-configuration
                    (xorg-configuration
                    (extra-config (list "
                      # Touchpad
                      Section \"InputClass\"
                      Identifier \"touchpad\"
                      Driver \"libinput\"
                      MatchIsTouchpad \"on\"
                      Option \"DisableWhileTyping\" \"1\"
                      Option \"Tapping\" \"1\"
                      Option \"NaturalScrolling\" \"1\"
                      Option \"Emulate3Buttons\" \"yes\"
                      EndSection
                      # Touchpad:1 ends here
                      ")))))

;;		  (xorg-configuration (keyboard-layout keyboard-layout)))))

           ;; This is the default list of services we
           ;; are appending to.
           %desktop-services))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                                  "cd2a4c74-be37-43b5-adb3-c631c8d8cee1"
                                  'ext4))
                         (type "ext4"))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "469E-7100"
                                       'fat32))
                         (type "vfat")) %base-file-systems)))
