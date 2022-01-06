
import Foundation

// MARK: - User
struct User: Codable {
    let jwt: String
    let user: UserInfo
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let id: Int
    let username, email: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, username, email
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

