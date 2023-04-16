import Foundation

typealias SpaceId = UInt
typealias DisplayId = UInt

struct Space: Identifiable, Decodable {
  let id: SpaceId
  let displayId: DisplayId
  let label: String
  let hasFocus: Bool
  let isVisible: Bool

  enum CodingKeys: String, CodingKey {
    case id = "index"
    case label
    case displayId = "display"
    case hasFocus = "has-focus"
    case isVisible = "is-visible"
  }
}
