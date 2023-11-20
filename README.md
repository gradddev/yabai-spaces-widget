# Yabai Spaces Widget

Yabai Spaces Widget is a macOS app that adds a widget to your status bar. It works with [yabai](https://github.com/koekeishiya/yabai) and lets you see spaces on all your displays. This makes it easy to switch between tasks and stay organized. It's a helpful tool for managing your workspaces on macOS.

<img width="1194" alt="Screenshot 2023-04-16 at 21 44 09" src="https://user-images.githubusercontent.com/4836709/232331557-646f23b4-e36c-4f27-baf1-a56212ba0532.png">

To install the widget using Homebrew, run the following command in your terminal:

```bash
brew install gradddev/tap/yabai-spaces-widget
```

To ensure that the widget stays up-to-date with the latest information about your spaces and displays, it is recommended that you add the following code snippet to your yabai configuration file (yabairc):
```bash
signals=(
   "space_changed"
   "display_added"
   "display_removed"
   "display_moved"
   "display_changed"
   "mission_control_enter"
   "mission_control_exit"
)
for signal in "${signals[@]}"
do
   yabai --message signal \
         --add \
            event=$signal \
            action="osascript -e 'tell application \"Yabai Spaces Widget\" to refresh'"
done
```

This code adds event listeners to yabai that listen for specific events such as space changes, display additions or removals, and Mission Control events. When any of these events occur, yabai will trigger a command that refreshes the widget using an AppleScript.
