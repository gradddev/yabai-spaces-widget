import SwiftUI

struct DisplayView: View {
  let spaces: [Space]

  var body: some View {
    HStack(spacing: 0) {
      ForEach(spaces) { space in
        SpaceView(space: space)
      }
    }
    .cornerRadius(4)
    .padding(1)
    .frame(height: 22)
  }
}
