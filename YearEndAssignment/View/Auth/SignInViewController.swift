
import UIKit

import SnapKit

class SignInViewController: UIViewController {
    
    let mainView = SignInView()
    var viewModel = AuthViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        viewModel.identifier.bind { text in
            self.mainView.identifierTextField.text = text
        }
        viewModel.password.bind { text in
            self.mainView.passwordTextField.text = text
        }
        viewModel.isEnabledSignInButton.bind({ isEnabled in
            self.mainView.signinButton.isEnabled = isEnabled
            if isEnabled {
                self.mainView.signinButton.backgroundColor = .systemGreen
            } else {
                self.mainView.signinButton.backgroundColor = .systemGray3
            }
        })
        
        mainView.identifierTextField.addTarget(self, action: #selector(identifierTextFieldDidChange(_:)), for: .editingChanged)
        mainView.identifierTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        
        
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        
        
        mainView.signinButton.addTarget(self, action: #selector(signinButtonClicked), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setCenterAlignedNavigationItemTitle(text: "새싹농장 시작하기", size: 18, color: .black, weight: .heavy)
    }
    
    func validateSignInForm() {
        if mainView.identifierTextField.text != "", mainView.passwordTextField.text != "" {
            viewModel.isEnabledSignInButton.value = true
        } else {
            viewModel.isEnabledSignInButton.value = false
        }
    }
    
    @objc func identifierTextFieldDidChange(_ textfield: UITextField) {
        viewModel.identifier.value = textfield.text ?? ""
        validateSignInForm()
    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
        validateSignInForm()
    }
    
    @objc func signinButtonClicked() {
        print(#function)
        
        viewModel.postUserSignin { error in
            
            if let error = error {
                
                // 에러 처리 - "Identifier or password invalid."
                if error == APIError.invalidIdOrPassword {
                    
                    self.showAlert(title: "", message: "유효하지 않은 아이디\n또는 비밀번호입니다.", okTitle: "확인", okCompletion: {
                        self.mainView.identifierTextField.text = ""
                        self.mainView.passwordTextField.text = ""
                        self.validateSignInForm()
                    }, cancleTitle: nil, cancleCompletion: nil)
                }
                return
                
                /*
                 - "Please provide your username or your e-mail."
                 - "Please provide your password."
                 위 두 에러는 클라이언트 단에서 처리(버튼 비활성화)
                 */
            }
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return
            }
            
            let window = windowScene.windows
                .first
            
            let duration = 0.5
            let options = UIView.AnimationOptions.transitionCrossDissolve
            let rootViewController = PostViewController()
            window?.changeRootViewControllerWithAnimation(duration: duration, options: options, rootViewController: rootViewController)
            
            
        }
    }
}
