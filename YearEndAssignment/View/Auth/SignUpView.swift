
import UIKit

import SnapKit

class SignUpView: UIView, ViewPresentable {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    let emailTextField = CustomUITextField()
    let usernameTextField = CustomUITextField()
    let passwordTextField = CustomUITextField()
    let confirmPasswordTextField = CustomUITextField()
    
    let signupButton = CustomUIButton()
    
    func setupView() {
        
        self.backgroundColor = .white
        
        addSubview(emailTextField)
        emailTextField.placeholder = "이메일 주소"
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        
        addSubview(usernameTextField)
        usernameTextField.placeholder = "닉네임"
        usernameTextField.autocapitalizationType = .none
        
        addSubview(passwordTextField)
        passwordTextField.placeholder = "비밀번호"
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        
        addSubview(confirmPasswordTextField)
        confirmPasswordTextField.placeholder = "비밀번호 확인"
        confirmPasswordTextField.autocapitalizationType = .none
        confirmPasswordTextField.isSecureTextEntry = true
        
        addSubview(signupButton)
        signupButton.setTitle("가입하기", for: .normal)
        signupButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .heavy)
        signupButton.backgroundColor = .systemGray3
        signupButton.isEnabled = false
    }
    
    func setupConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.centerX.equalTo(emailTextField.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(10)
            make.centerX.equalTo(usernameTextField.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.centerX.equalTo(passwordTextField.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(10)
            make.centerX.equalTo(confirmPasswordTextField.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
    }
}
