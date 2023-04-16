import SwiftUI

class RightClickableNSView: NSView {
  typealias Action = () -> Void

  private var onRightMouseDown: Action? = nil
  private var onRightMouseUp: Action? = nil

  convenience init(onRightMouseDown: Action? = nil, onRightMouseUp: Action? = nil) {
    self.init()
    self.onRightMouseDown = onRightMouseDown
    self.onRightMouseUp = onRightMouseUp
  }

  override func layout() {
    self.frame = self.superview!.frame
  }

  private let allowedEventTypes: [NSEvent.EventType?] = [.rightMouseDown, .rightMouseUp]

  override func hitTest(_ point: NSPoint) -> NSView? {
    if allowedEventTypes.contains(NSApplication.shared.currentEvent?.type) {
      return super.hitTest(point)
    }
    return nil
  }

  override func rightMouseDown(with event: NSEvent) {
    onRightMouseDown?()
  }

  override func rightMouseUp(with event: NSEvent) {
    onRightMouseUp?()
  }
}
