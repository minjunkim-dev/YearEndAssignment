
import Foundation

// MARK: - RequestError
struct RequestError: Codable {
    let statusCode: Int
    let error: String
    let message, data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let messages: [Message]
}

// MARK: - Message
struct Message: Codable {
    let id, message: String
}
