

import UIKit

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
        case .putPosts(let postId):
            return .makeEndpoint(endpoint: "/posts/\(postId)")
        case .deletePosts(let postId):
            return .makeEndpoint(endpoint: "/posts/\(postId)")
            
        case .getComments(let postId):
            return .makeEndpoint(endpoint: "/comments?post=\(postId)")
        case .postComments:
            return .makeEndpoint(endpoint: "/comments")
        case .putComments(let commentId):
            return .makeEndpoint(endpoint: "/comments/\(commentId)")
        case .deleteComments(let commentId):
            return .makeEndpoint(endpoint: "/comments/\(commentId)")
    
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
                    
                    
                    let decoder = JSONDecoder()
                    
                    if response.statusCode == 400 {
                        
                        do {
                            // sign error
                            let requestError = try decoder.decode(SignError.self, from: data)
                            if let message = requestError.message.first?.messages.first?.message {
                                
                                if message == "Email is already taken." {
                                    print("????????? ??????")
                                    completion(nil, .duplicateEmail)
                                }
                            
                                if message == "Please provide valid email address." {
                                    print("????????? ????????? ??????")
                                    completion(nil, .invalidEmail)
                                }
                                
                                if message == "Identifier or password invalid." {
                                    print("???????????? ?????? ????????? ?????? ????????????")
                                    completion(nil, .invalidIdOrPassword)
                                }
                                
                                completion(nil, .failed)
                                return
                            }
                            
                        } catch {
                            do {
                                
                                // change password error
                                let changePasswordError = try decoder.decode(ChangePasswordError.self, from: data)

                                
                                if changePasswordError.message == "Current password does not match." {
                                    print("?????? ??????????????? ???????????? ??????")
                                    completion(nil, .currentPasswordNotMatch)
                                }
                                
                                if changePasswordError.message == "New passwords do not match." {
                                    print("????????? ??????????????? ???????????? ??????")
                                    completion(nil, .newPasswordNotMatch)
                                }
                                
                                completion(nil, .failed)
                                return
                                
                            } catch {
                                
                                completion(nil, .failed)
                                return
                            }
                        }
                        
                        completion(nil, .failed)
                        return
                    }
                    
                    // invalid token error
                    if response.statusCode == 401 {
                        
                        do  {
                            let invalidTokenError = try decoder.decode(InvalidTokenError.self, from: data)
                    
                            if invalidTokenError.message == "Invalid token." {
                                print("????????? ???????????? ??????")
                                
                                /* ?????? ???????????? ?????? */
                                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                                    return
                                }
                                
                                let window = windowScene.windows
                                    .first
                                
                                let duration = 0.5
                                let options = UIView.AnimationOptions.transitionCrossDissolve
                                let rootViewController = AuthViewController()
                                window?.changeRootViewControllerWithAnimation(duration: duration, options: options, rootViewController: rootViewController)
                                
                                completion(nil, .invalidToken)
                                return
                            }
                        } catch {
                            completion(nil, .failed)
                            return
                        }
                        
                        completion(nil, .failed)
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
