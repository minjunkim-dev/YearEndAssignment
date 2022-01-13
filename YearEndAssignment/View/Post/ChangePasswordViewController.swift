
import UIKit

import SnapKit

class ChangePasswordViewController: UIViewController {
    
    let mainView = ChangePasswordView()
    var viewModel = PostViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setCenterAlignedNavigationItemTitle(text: "새싹농장 비밀번호 변경하기", size: 18, color: .black, weight: .heavy)
        
    
        viewModel.password.bind { text in
            self.mainView.passwordTextField.text = text
        }
        viewModel.newPassword.bind { text in
            self.mainView.newPasswordTextField.text = text
        }
        viewModel.confirmNewPassword.bind { text in
            self.mainView.confirmNewPasswordTextField.text = text
        }
        viewModel.isEnabledChangePasswordButton.bind { isEnabled in
            self.mainView.changePasswordButton.isEnabled = isEnabled
            if isEnabled {
                self.mainView.changePasswordButton.backgroundColor = .systemGreen
            } else {
                self.mainView.changePasswordButton.backgroundColor = .systemGray3
            }
        }
        
        
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        
        
        mainView.newPasswordTextField.addTarget(self, action: #selector(newPasswordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.newPasswordTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        
    
        mainView.confirmNewPasswordTextField.addTarget(self, action: #selector(confirmNewPasswordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.confirmNewPasswordTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        
        
        
        mainView.changePasswordButton.addTarget(self, action: #selector(changePasswordButtonClicked), for: .touchUpInside)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func validateChangePasswordForm() {
        
        if mainView.passwordTextField.text != "",
           mainView.newPasswordTextField.text != "",
           mainView.confirmNewPasswordTextField.text != "" {
            
            viewModel.isEnabledChangePasswordButton.value = true
        } else {
            viewModel.isEnabledChangePasswordButton.value = false
        }
    }
  
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
        validateChangePasswordForm()
    }

    @objc func newPasswordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.newPassword.value = textfield.text ?? ""
        validateChangePasswordForm()
    }

    @objc func confirmNewPasswordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.confirmNewPassword.value = textfield.text ?? ""
        validateChangePasswordForm()
    }
    
    @objc func changePasswordButtonClicked() {
        
       
        viewModel.postUserChangePassword { error in
            
            if let error = error {
                
                print("viewcon에서 에러 확인!")
                dump(error)
                
                if error == APIError.currentPasswordNotMatch {
                    
                    let message = "현재 비밀번호가 틀렸어요"
                    self.showAlert(title: nil, message: message, okTitle: "확인", okCompletion: {
                        self.mainView.passwordTextField.text = ""
                        self.validateChangePasswordForm()
                    }, cancleTitle: nil, cancleCompletion: nil)
                }
                
                else if error == APIError.newPasswordNotMatch {
                    
                    let message = "새 비밀번호가 서로 일치하지 않아요"
                    self.showAlert(title: nil, message: message, okTitle: "확인", okCompletion: {
                        self.mainView.newPasswordTextField.text = ""
                        self.mainView.confirmNewPasswordTextField.text = ""
                        self.validateChangePasswordForm()
                    }, cancleTitle: nil, cancleCompletion: nil)
                }
                
                return
            }
            
            self.showAlert(title: nil, message: "비밀번호가 바뀌었어요", okTitle: "확인", okCompletion: {
                
                self.navigationController?.popViewController(animated: true)
                
            }, cancleTitle: nil, cancleCompletion: nil)
            
        }
    }
        
}
