
import UIKit

import SnapKit

class SignInView: UIView, ViewPresentable {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    let identifierTextField = AuthUITextField()
    let passwordTextField = AuthUITextField()
    
    let signinButton = AuthUIButton()

    func setupView() {
        
        self.backgroundColor = .white
        
        addSubview(identifierTextField)
        identifierTextField.placeholder = "이메일 주소 또는 닉네임"
        identifierTextField.autocapitalizationType = .none
        identifierTextField.keyboardType = .emailAddress
        
        addSubview(passwordTextField)
        passwordTextField.placeholder = "비밀번호"
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        
        addSubview(signinButton)
        signinButton.setTitle("시작하기", for: .normal)
        signinButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .heavy)
        signinButton.backgroundColor = .lightGray

    }
    
    func setupConstraints() {
        identifierTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
    
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(identifierTextField.snp.bottom).offset(10)
            make.centerX.equalTo(identifierTextField.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        signinButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.centerX.equalTo(passwordTextField.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
    }
}
