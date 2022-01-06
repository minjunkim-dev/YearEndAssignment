
import UIKit

class SignInViewController: UIViewController {
    
    let mainView = SignInView()
    var viewModel = AuthViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "새싹농장 시작하기"
        navigationItem.backButtonTitle = ""
        
        viewModel.identifier.bind { text in
            self.mainView.identifierTextField.text = text
        }
        viewModel.password.bind { text in
            self.mainView.passwordTextField.text = text
        }
        
        mainView.identifierTextField.addTarget(self, action: #selector(identifierTextFieldDidChange(_:)), for: .editingChanged)
        mainView.identifierTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        

        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        
        
        mainView.signinButton.addTarget(self, action: #selector(signinButtonClicked), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    func activateSignInButton() {
        guard mainView.identifierTextField.text != "", mainView.passwordTextField.text != "" else {
            mainView.signinButton.backgroundColor = .lightGray
            return
        }
        mainView.signinButton.backgroundColor = .systemGreen
    }
    
    @objc func identifierTextFieldDidChange(_ textfield: UITextField) {
        viewModel.identifier.value = textfield.text ?? ""
        activateSignInButton()
    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
        activateSignInButton()
    }
    
    @objc func signinButtonClicked() {
                
        viewModel.postUserSignin { error in
            
            if let error = error {
                
                if error == APIError.invalidIdOrPassword {
                    
                    self.showAlert(title: "유효하지 않은 정보", message: "유효하지 않은 아이디\n또는 비밀번호입니다.", okTitle: "확인", okCompletion: {
                        self.mainView.identifierTextField.text = ""
                        self.mainView.passwordTextField.text = ""
                        self.activateSignInButton()
                    }, cancleTitle: nil, cancleCompletion: nil)

                }
                return
            }
            
            DispatchQueue.main.async {
                
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                    return
                }

                let window = windowScene.windows
                    .first
                
                let duration = 1.0
                let options = UIView.AnimationOptions.transitionCrossDissolve
                let rootViewController = PostViewController()
                window?.changeRootViewControllerWithAnimation(duration: duration, options: options, rootViewController: rootViewController)
            
            }
        }
    }
}
