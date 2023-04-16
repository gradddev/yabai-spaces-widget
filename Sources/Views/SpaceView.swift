import SwiftUI

struct SpaceView: View {
  let space: Space

  @Environment(\.colorScheme)
  private var colorScheme: ColorScheme

  @State
  private var isPressed = false

  private var backgroundColor: Color {
    let color: Color = colorScheme == .dark ? .white : .black
    if space.hasFocus { return color }
    if isPressed { return color.opacity(0.2) }
    return color.opacity(0.1)
  }

  private var foregroundColor: Color {
    if space.hasFocus {
      return colorScheme == .dark ? .black : .white
    }
    return colorScheme == .dark ? .white : .black
  }

  var body: some View {
    Rectangle()
      .fill(backgroundColor)
      .frame(width: 20, height: 20)
      .overlay {
        Text(String(space.id))
          .foregroundColor(foregroundColor)
      }
      .simultaneousGesture(
        DragGesture(minimumDistance: 0)
          .onChanged { _ in
            isPressed = true
          }
          .onEnded { _ in
            isPressed = false

            try? YabaiService.shared.focusSpace(by: space.id)
          }
      )
  }
}
