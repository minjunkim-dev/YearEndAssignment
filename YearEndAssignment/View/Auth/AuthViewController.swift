
import UIKit

class AuthViewController: UIViewController {

    let mainView = AuthView()
    var viewModel = AuthViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        mainView.signinButton.addTarget(self, action: #selector(signinButtonClicked), for: .touchUpInside)
        
        navigationItem.backButtonTitle = ""
    }
    
    @objc func signupButtonClicked() {
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func signinButtonClicked() {
        let vc = SignInViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

