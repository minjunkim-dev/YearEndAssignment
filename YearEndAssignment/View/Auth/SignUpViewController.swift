
import UIKit

class SignUpViewController: UIViewController {
    
    let mainView = SignUpView()
    var viewModel = AuthViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "새싹농장 가입하기"
        
        
        viewModel.email.bind { text in
            self.mainView.emailTextField.text = text
        }
        viewModel.nickname.bind { text in
            self.mainView.nicknameTextField.text = text
        }
        viewModel.password.bind { text in
            self.mainView.passwordTextField.text = text
        }
        viewModel.confirmNewPassword.bind { text in
            self.mainView.confirmPasswordTextField.text = text
        }
        
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        mainView.emailTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        
    
        mainView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange(_:)), for: .editingChanged)
        mainView.nicknameTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        
        
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        
        
        mainView.confirmPasswordTextField.addTarget(self, action: #selector(confirmPasswordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.confirmPasswordTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        
        
        mainView.signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func activateSignUpButton() {
        guard mainView.emailTextField.text != "", mainView.nicknameTextField.text != "",
              mainView.passwordTextField.text != "", mainView.confirmPasswordTextField.text != "" else {
                  mainView.signupButton.backgroundColor = .lightGray
                  return
              }
        mainView.signupButton.backgroundColor = .systemGreen
    }
    
    @objc func emailTextFieldDidChange(_ textfield: UITextField) {
        viewModel.email.value = textfield.text ?? ""
        activateSignUpButton()
    }
    
    @objc func nicknameTextFieldDidChange(_ textfield: UITextField) {
        viewModel.nickname.value = textfield.text ?? ""
        activateSignUpButton()
    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
        activateSignUpButton()
    }
    
    @objc func confirmPasswordTextFieldDidChange(_ textfield: UITextField) {
        activateSignUpButton()
    }
    
    @objc func signupButtonClicked() {

        if mainView.passwordTextField.text != mainView.confirmPasswordTextField.text {
            showAlert(title: "비밀번호 불일치", message: "비밀번호가 다릅니다.", okTitle: "확인", okCompletion: {
                self.mainView.passwordTextField.text = ""
                self.mainView.confirmPasswordTextField.text = ""
                self.activateSignUpButton()
            }, cancleTitle: nil, cancleCompletion: nil)
            
            return
        }
            
        
        viewModel.postUserSignup { error in
            
            if let error = error {
                
                if error == APIError.duplicateEmail {
                    
                    self.showAlert(title: "이메일 중복", message: "이미 등록된 이메일입니다.", okTitle: "확인", okCompletion: {
                        self.mainView.emailTextField.text = ""
                        self.activateSignUpButton()
                    }, cancleTitle: nil, cancleCompletion: nil)
                }
                return
            }
        
            DispatchQueue.main.async {
                self.showAlert(title: "가입 완료", message: "가입이 완료되었습니다.", okTitle: "확인", okCompletion: {
                    self.navigationController?.popViewController(animated: true)
                    let vc = SignInViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }, cancleTitle: nil, cancleCompletion: nil)
            }
        }
    
    }
}

