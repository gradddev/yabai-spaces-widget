import Foundation
import SwiftUI

struct WidgetView: View {
  let onResize: (_ size: NSSize) -> Void

  @State
  private var spaces = try? YabaiService.shared.querySpaces()

  private var spacesByDisplay: [DisplayId: [Space]] {
    return Dictionary(grouping: spaces ?? [], by: { $0.displayId })
  }

  private var displayIds: [DisplayId] {
    return spacesByDisplay.keys.sorted()
  }

  var body: some View {
    VStack {
      if spaces != nil {
        HStack(spacing: 8) {
          ForEach(displayIds, id: \.self) { displayId in
            DisplayView(spaces: spacesByDisplay[displayId]!)
          }
        }
      } else {
        ErrorView()
      }
    }
    .background(
      GeometryReader { geometry -> Color in
        onResize(geometry.frame(in: .local).size)
        return Color.clear
      }
    )
    .onReceive(NotificationCenter.default.publisher(for: .refreshWidget)) { _ in
      spaces = try? YabaiService.shared.querySpaces()
    }
  }
}
