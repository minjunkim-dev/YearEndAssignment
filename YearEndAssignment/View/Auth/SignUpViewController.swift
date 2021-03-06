
import UIKit

import SnapKit

class SignUpViewController: UIViewController {
    
    let mainView = SignUpView()
    var viewModel = AuthViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.email.bind { text in
            self.mainView.emailTextField.text = text
        }
        viewModel.username.bind { text in
            self.mainView.usernameTextField.text = text
        }
        viewModel.password.bind { text in
            self.mainView.passwordTextField.text = text
        }
        viewModel.confirmPassword.bind { text in
            self.mainView.confirmPasswordTextField.text = text
        }
        viewModel.isEnabledSignUpButton.bind { isEnabled in
            self.mainView.signupButton.isEnabled = isEnabled
            if isEnabled {
                self.mainView.signupButton.backgroundColor = .systemGreen
            } else {
                self.mainView.signupButton.backgroundColor = .systemGray3
            }
        }
        
        
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        mainView.emailTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        
        
        mainView.usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        mainView.usernameTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        
        
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        
        
        mainView.confirmPasswordTextField.addTarget(self, action: #selector(confirmPasswordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.confirmPasswordTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        
        
        mainView.signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setCenterAlignedNavigationItemTitle(text: "???????????? ????????????", size: 18, color: .black, weight: .heavy)
        
    }
    
    func validateSignUpForm() {
        
        if mainView.emailTextField.text != "", mainView.usernameTextField.text != "",
           mainView.passwordTextField.text != "", mainView.confirmPasswordTextField.text != "" {
            
            viewModel.isEnabledSignUpButton.value = true
        }
        else {
            
            viewModel.isEnabledSignUpButton.value = false
        }
    }
    
    @objc func emailTextFieldDidChange(_ textfield: UITextField) {
        viewModel.email.value = textfield.text ?? ""
        validateSignUpForm()
    }
    
    @objc func usernameTextFieldDidChange(_ textfield: UITextField) {
        viewModel.username.value = textfield.text ?? ""
        validateSignUpForm()
    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
        validateSignUpForm()
    }
    
    @objc func confirmPasswordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.confirmPassword.value = textfield.text ?? ""
        validateSignUpForm()
    }
    
    @objc func signupButtonClicked() {
        print(#function)
        
        // ?????? ??????: ???????????? ?????????(??????????????? ????????? ??????)
        if mainView.passwordTextField.text != mainView.confirmPasswordTextField.text {
            showAlert(title: nil, message: "??????????????? ?????????", okTitle: "??????", okCompletion: {
                self.mainView.passwordTextField.text = ""
                self.mainView.confirmPasswordTextField.text = ""
                self.validateSignUpForm()
            }, cancleTitle: nil, cancleCompletion: nil)
            
            return
        }
        
        // "Please provide your password" ????????? ??????????????? ????????? ??????(?????? ????????????)
        
        
        
        viewModel.postUserSignup { error in
            
            if let error = error {
                
                if error == APIError.duplicateEmail {
                    
                    let message = "?????? ????????? ??????????????????"
                    self.showAlert(title: nil, message: message, okTitle: "??????", okCompletion: {
                        self.mainView.emailTextField.text = ""
                        self.validateSignUpForm()
                    }, cancleTitle: nil, cancleCompletion: nil)
                }
                
                else if error == APIError.invalidEmail {
                    
                    let message = "????????? ????????? ????????? ????????????"
                    self.showAlert(title: nil, message: message, okTitle: "??????", okCompletion: {
                        self.mainView.emailTextField.text = ""
                        self.validateSignUpForm()
                    }, cancleTitle: nil, cancleCompletion: nil)
                }
                
                return
            }
            
            self.showAlert(title: nil, message: "????????? ??????????????????", okTitle: "??????", okCompletion: {
                
                let vc = SignInViewController()
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.pushViewController(vc, animated: true)
            }, cancleTitle: nil, cancleCompletion: nil)
            
        }
    }
}

