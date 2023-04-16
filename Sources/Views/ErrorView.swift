import SwiftUI

struct ErrorView: View {
  var body: some View {
    Rectangle()
      .fill(.red)
      .frame(width: 128, height: 22)
      .cornerRadius(4)
      .overlay {
        Text("Yabai not found.").foregroundColor(.white)
      }
  }
}
