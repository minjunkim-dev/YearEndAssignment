
import Foundation

// MARK: - Comment
struct Comment: Codable {
    let id: Int
    var comment: String
    let user: Int
    let post: Int?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - CommentDetail
struct CommentDetail: Codable {
    let id: Int
    var comment: String
    let user: UserInfo
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
