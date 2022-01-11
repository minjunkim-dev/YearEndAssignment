import Foundation

// MARK: - Post
struct Post: Codable {
    let id: Int
    var text: String
    let user: UserInfo
    let createdAt, updatedAt: String
    let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case comments
    }
}
