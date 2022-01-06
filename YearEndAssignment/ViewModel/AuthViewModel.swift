
import Foundation

class AuthViewModel {
    
    var email: Observable<String> = Observable("")
    var nickname: Observable<String> = Observable("")
    var identifier: Observable<String> = Observable("") // email or nickname
    
    var password: Observable<String> = Observable("")
    var newPassword: Observable<String> = Observable("")
    var confirmNewPassword: Observable<String> = Observable("")
    
    func postUserSignin(completion: @escaping (APIError?) -> Void) {
        APIService.signin(identifier: identifier.value, password: password.value) { data, error in

            if let data = data {
                print("로그인 성공!")
//                dump(data)
                
                /* token */
                UserDefaults.standard.set(data.jwt, forKey: "token")
                
                /* identifier */
                UserDefaults.standard.set(data.user.email, forKey: "identifier")
                
                /* identifier */
                UserDefaults.standard.set(self.password.value, forKey: "password")
                
                completion(nil)
            } else {
                print("로그인 실패!")
                dump(error)
                completion(error)
            }
            
        }
    }
    
    func postUserSignup(completion: @escaping (APIError?) -> Void) {
        APIService.signup(username: nickname.value, email: email.value, password: password.value) { data, error in

            if let data = data {
                print("가입 성공!")
//                dump(data)
                completion(nil)
            } else {
                print("가입 실패!")
                dump(error)
                completion(error)
            }
        }
    }
    
    func postUserChangePassword(completion: @escaping (APIError?) -> Void) {
        APIService.changePassword(currentPassword: password.value, newPassword: newPassword.value, confirmNewPassword: confirmNewPassword.value) { data, error in
            
            if let data = data {
                print("비밀번호 변경 성공!")
//                dump(data)
                completion(nil)
            } else {
                print("비밀번호 변경 실패!")
                dump(error)
                completion(error)
            }
        }
    }
}
