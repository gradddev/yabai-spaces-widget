import Cocoa

class RefreshScriptCommand: NSScriptCommand {
  override func performDefaultImplementation() -> Any? {
    NotificationCenter.default.post(name: .refreshWidget, object: nil)
    return nil
  }
}
