import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterviewController = FlutterviewController()
    let windowFrame = self.frame
    self.contentviewController = flutterviewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterviewController)

    super.awakeFromNib()
  }
}
