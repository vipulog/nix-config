{pkgs, ...}:
pkgs.writeShellScriptBin "power-tofi" ''
  options="Suspend\nReboot\nLogout\nShutdown"
  choice=$(echo -e "$options" | ${pkgs.tofi}/bin/tofi --prompt-text "Power Menu:")

  # Get the current logged-in username
  USERNAME=$(whoami)

  case "$choice" in
    "Shutdown")
      systemctl poweroff
      ;;
    "Reboot")
      systemctl reboot
      ;;
    "Suspend")
      systemctl suspend
      ;;
    "Logout")
      loginctl terminate-user $USERNAME
      ;;
    *)
      echo "No option selected or invalid option."
      ;;
  esac
''
