import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
  var statusItem: NSStatusItem!
  var hostingView: NSHostingView<WidgetView>!

  func applicationDidFinishLaunching(_ notification: Notification) {
    NSWorkspace.shared.runningApplications
      .forEach {
        if $0.bundleIdentifier != Bundle.main.bundleIdentifier { return }
        if $0.processIdentifier == ProcessInfo.processInfo.processIdentifier { return }
        $0.terminate()
      }

    NSApp.setActivationPolicy(.accessory)
    NSApp.activate(ignoringOtherApps: true)

    statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    statusItem.button?.isEnabled = false
    statusItem.button?.autoresizesSubviews = true

    hostingView = NSHostingView(
      rootView: WidgetView { size in
        self.hostingView.frame = .init(origin: .zero, size: size)
        self.statusItem.button?.frame = self.hostingView.frame
      }
    )
    statusItem.button?.subviews.append(hostingView)

    let rightClickableView = RightClickableNSView(
      onRightMouseDown: { NSApp.activate(ignoringOtherApps: true) },
      onRightMouseUp: {
        self.statusItem?.button?.isEnabled = true
        self.statusItem?.button?.performClick(nil)
        self.statusItem?.button?.isEnabled = false
      }
    )
    statusItem.button?.subviews.append(rightClickableView)

    statusItem.menu = NSMenu()
    statusItem.menu?.addItem(
      withTitle: "About",
      action: #selector(NSApplication.shared.orderFrontStandardAboutPanel(_:)),
      keyEquivalent: "a"
    )
    statusItem.menu?.addItem(.separator())
    statusItem.menu?.addItem(
      withTitle: "Quit",
      action: #selector(NSApplication.shared.terminate),
      keyEquivalent: "q"
    )
  }
}
