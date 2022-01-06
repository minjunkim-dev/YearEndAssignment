
import Foundation

enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
    case duplicateEmail
    case invalidIdOrPassword
    case oldPasswordNotMatch
}

extension APIError {
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "invalidResponse"
        case .noData:
            return "noData"
        case .failed:
            return "failed"
        case .invalidData:
            return "invalidData"
        case .duplicateEmail:
            return "duplicateEmail"
        case .invalidIdOrPassword:
            return "invalidIdOrPassword"
        case .oldPasswordNotMatch:
            return "oldPasswordNotMatch"
        }
    }
}

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

class APIService {
    
    static func signin(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {

        var request = URLRequest(url: Endpoint.signin.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
                
        URLSession.request(session: .shared, endpoint: request, completion: completion)
    }
    
    static func signup(username: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.signup.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(session: .shared, endpoint: request, completion: completion)
    }
    
    static func getContent(token: String, completion: @escaping ([Post]?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.getPostsDesc.url)
        request.httpMethod = Method.GET.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.request(session: .shared, endpoint: request, completion: completion)
    }
    
    static func postContent(token: String, text: String, completion: @escaping (Post?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.postPosts.url)
        request.httpMethod = Method.POST.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(session: .shared, endpoint: request, completion: completion)
    }
    
    static func putContent(token: String, text: String, postId: Int, completion: @escaping (Post?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.putPosts(id: postId).url)
        request.httpMethod = Method.PUT.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(session: .shared, endpoint: request, completion: completion)
        
    }
    
    static func deleteContent(token: String, postId: Int, completion: @escaping (Post?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.deletePosts(id: postId).url)
        request.httpMethod = Method.DELETE.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.request(session: .shared, endpoint: request, completion: completion)
    }
    
    static func changePassword(currentPassword: String, newPassword: String, confirmNewPassword: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.changePassword.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "currentPassword=\(currentPassword)&newPassword=\(confirmNewPassword)&confirmNewPassword=\(confirmNewPassword)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(session: .shared, endpoint: request, completion: completion)
    }
}
