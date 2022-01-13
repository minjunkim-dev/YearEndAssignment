
import Foundation

class AuthViewModel {
    
    var email: Observable<String> = Observable("")
    var username: Observable<String> = Observable("")
    var identifier: Observable<String> = Observable("") // email
    
    var password: Observable<String> = Observable("")
    var confirmPassword: Observable<String> = Observable("")
    
    var isEnabledSignUpButton: Observable<Bool> = Observable(false)
    var isEnabledSignInButton: Observable<Bool> = Observable(false)
        
    /* SignUp View */
    func postUserSignup(completion: @escaping (APIError?) -> Void) {
        APIService.signup(username: username.value, email: email.value, password: password.value) { data, error in

            if let data = data {
                print("가입 성공!")
                completion(nil)
            } else {
                print("가입 실패!")
                dump(error)
                completion(error)
            }
        }
    }
    
    /* SignIn View */
    func postUserSignin(completion: @escaping (APIError?) -> Void) {
        APIService.signin(identifier: identifier.value, password: password.value) { data, error in

            if let data = data {
                print("로그인 성공!")
                
                /* token */
                UserDefaults.standard.set(data.jwt, forKey: "token")
                /* identifier */
                UserDefaults.standard.set(data.user.email, forKey: "identifier")
                /* password */
                UserDefaults.standard.set(self.password.value, forKey: "password")
                
                completion(nil)
            } else {
                print("로그인 실패!")
                dump(error)
                completion(error)
            }
            
        }
    }
    
    
    
}
