import Foundation

struct YabaiError: Error {
  let description: String
}

class YabaiService {
  private init() {}

  static let shared = YabaiService()

  private var process: Process? = nil

  func querySpaces() throws -> [Space] {
    let standardOutput = Pipe()
    let standardError = Pipe()

    process = Process()
    process?.arguments = ["-c", "yabai -m query --spaces"]
    process?.executableURL = URL(fileURLWithPath: "/bin/zsh")
    process?.standardInput = nil
    process?.standardOutput = standardOutput
    process?.standardError = standardError
    try process?.run()

    process?.waitUntilExit()

    let error = standardError.fileHandleForReading.availableData
    let data = standardOutput.fileHandleForReading.availableData

    if let error = String(data: error, encoding: .utf8), !error.isEmpty {
      throw YabaiError(description: error)
    }

    guard let spaces = try? JSONDecoder().decode([Space].self, from: data) else {
      throw YabaiError(description: "Invalid JSON")
    }

    return spaces
  }

  func focusSpace(by id: SpaceId) throws {
    let process = Process()

    process.arguments = ["-c", "yabai -m space --focus \(id)"]
    process.executableURL = URL(fileURLWithPath: "/bin/zsh")
    process.standardInput = nil

    try process.run()
  }
}
