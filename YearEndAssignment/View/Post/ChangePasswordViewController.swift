
import UIKit

import SnapKit

class ChangePasswordViewController: UIViewController {
    
    let mainView = ChangePasswordView()
    var viewModel = PostViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setCenterAlignedNavigationItemTitle(text: "새싹농장 비밀번호 변경하기", size: 18, color: .black, weight: .heavy)
        
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        viewModel.password.bind { text in
            self.mainView.passwordTextField.text = text
        }
        
        
        mainView.newPasswordTextField.addTarget(self, action: #selector(newPasswordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.newPasswordTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        viewModel.newPassword.bind { text in
            self.mainView.newPasswordTextField.text = text
        }
    
        mainView.confirmNewPasswordTextField.addTarget(self, action: #selector(confirmNewPasswordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.confirmNewPasswordTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        viewModel.confirmNewPassword.bind { text in
            self.mainView.confirmNewPasswordTextField.text = text
        }
        
        
        mainView.changePasswordButton.addTarget(self, action: #selector(changePasswordButtonClicked), for: .touchUpInside)
        
        doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonClicked))
        navigationItem.rightBarButtonItems = [doneButton]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func doneButtonClicked() {
        
        viewModel.postUserChangePassword { error in
            if let error = error {
                dump(error)
                
                return
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }

    func activateChangePasswordButton() {
        guard mainView.passwordTextField.text != "",
              mainView.newPasswordTextField.text != "", mainView.confirmNewPasswordTextField.text != "" else {
                  mainView.changePasswordButton.backgroundColor = .lightGray
                  return
              }
        mainView.changePasswordButton.backgroundColor = .systemGreen
    }
  
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
        activateChangePasswordButton()
    }

    @objc func newPasswordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.newPassword.value = textfield.text ?? ""
        activateChangePasswordButton()
    }

    @objc func confirmNewPasswordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.confirmNewPassword.value = textfield.text ?? ""
        activateChangePasswordButton()
    }
    
    @objc func changePasswordButtonClicked() {
        
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
}
