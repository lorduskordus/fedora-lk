# Set GRUB to auto-hide even with a Windows dual boot
grub-set-auto-hide-windows:
    #!/usr/bin/env bash
    if pkexec grub2-editenv list | grep -q 'menu_auto_hide=2'; then
        echo "Already set."
        exit 0
    else
        if pkexec grub2-editenv - set menu_auto_hide=2; then
            echo "Done."
            exit 0
        else
            echo "There was some error. Do you have privileges ?"
            exit 1
        fi
    fi
