
import Foundation

enum Endpoint {
    case signup
    case signin
    
    
    case getPosts
    case getPostsAsc
    case getPostsDesc
    case postPosts
    case putPosts(id: Int)
    case deletePosts(id: Int)
    
    
    case getComments(id: Int)
    case postComments
    case putComments(id: Int)
    case deleteComments(id: Int)
    
    
    case changePassword
}

extension Endpoint {
    var url: URL {
        switch self {
        case .signup: return .makeEndpoint(endpoint: "/auth/local/register")
        case .signin: return .makeEndpoint(endpoint: "/auth/local")
    
            
            
        case .getPosts: return .makeEndpoint(endpoint: "/posts")
        case .getPostsAsc: return .makeEndpoint(endpoint: "/posts" + "?_sort=created_at:asc")
        case .getPostsDesc: return .makeEndpoint(endpoint: "/posts" + "?_sort=created_at:desc")
        case .postPosts: return .makeEndpoint(endpoint: "/posts")
        case .putPosts(let id):
            return .makeEndpoint(endpoint: "/posts/\(id)")
        case .deletePosts(let id):
            return .makeEndpoint(endpoint: "/posts/\(id)")
            
        case .getComments(let id):
            return .makeEndpoint(endpoint: "/comments?post=\(id)")
        case .postComments:
            return .makeEndpoint(endpoint: "/comments")
        case .putComments(let id):
            return .makeEndpoint(endpoint: "/comments/\(id)")
        case .deleteComments(let id):
            return .makeEndpoint(endpoint: "/comments/\(id)")
    
        case .changePassword: return .makeEndpoint(endpoint: "/custom/change-password")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com:1231"
    
    static func makeEndpoint(endpoint: String) -> URL {
        return URL(string: baseURL + endpoint)!
    }
}

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
        
        session.dataTask(endpoint: endpoint) { data, response, error in
            DispatchQueue.main.async {
                
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print(response.statusCode)
                    
                    let decoder = JSONDecoder()
                    let requestError = try! decoder.decode(RequestError.self, from: data)
                    
                    if let message = requestError.message.first?.messages.first?.message {
                        
                        if message == "Email is already taken." {
                            print("이메일 중복")
                            completion(nil, .duplicateEmail)
                        }
                    
                        if message == "Identifier or password invalid." {
                            print("유효하지 않은 이메일 또는 비밀번호")
                            completion(nil, .invalidIdOrPassword)
                        }
                        
                        return
                    }
                    
                    completion(nil, .failed)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    completion(result, nil)
                } catch {
                    dump(error) // decode error
                    completion(nil, .invalidData)
                }
            }
        }
    }
}
