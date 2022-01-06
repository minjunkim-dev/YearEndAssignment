
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
        
        navigationItem.title = "새싹농장 비밀번호 변경하기"
        
//        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
//        mainView.passwordTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
//        
//        
//        mainView.newPasswordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
//        mainView.newPasswordTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
//        
//    
//        mainView.confirmNewPasswordTextField.addTarget(self, action: #selector(confirmNewPasswordTextFieldDidChange(_:)), for: .editingChanged)
//        mainView.confirmNewPasswordTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
//        
//        mainView.changePasswordButton.addTarget(self, action: #selector(changePasswordButtonClicked), for: .touchUpInside)
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
//        view.addGestureRecognizer(tap)
    }

    func activateChangePasswordButton() {
        guard mainView.passwordTextField.text != "",
              mainView.newPasswordTextField.text != "", mainView.confirmNewPasswordTextField.text != "" else {
                  mainView.changePasswordButton.backgroundColor = .lightGray
                  return
              }
        mainView.changePasswordButton.backgroundColor = .systemGreen
    }
    
//    @objc func identifierTextFieldDidChange(_ textfield: UITextField) {
//        viewModel.identifier.value = textfield.text ?? ""
//        activateChangePasswordButton()
//    }
//
//    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
//        viewModel.password.value = textfield.text ?? ""
//        activateChangePasswordButton()
//    }
//
//    @objc func newPasswordTextFieldDidChange(_ textfield: UITextField) {
//        viewModel.newPassword.value = textfield.text ?? ""
//        activateChangePasswordButton()
//    }
//
//    @objc func confirmNewPasswordTextFieldDidChange(_ textfield: UITextField) {
//        viewModel.confirmNewPassword.value = textfield.text ?? ""
//        activateChangePasswordButton()
//    }
    
    @objc func changePasswordButtonClicked() {
        
        DispatchQueue.main.async {
//            self.navigationController?.popViewController(animated: true)
//            self.dismiss(animated: true, completion: nil)
        }
    }
}
