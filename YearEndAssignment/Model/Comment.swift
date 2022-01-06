
// MARK: - Comment
struct Comment: Codable {
    let id: Int
    let comment: String
    let user, post: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Post
struct CommentDetail: Codable {
    let id: Int
    let comment: String
    let user: UserInfo
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
