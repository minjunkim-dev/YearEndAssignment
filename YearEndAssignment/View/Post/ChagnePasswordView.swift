
import UIKit

import SnapKit

class ChangePasswordView: UIView, ViewPresentable {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    let passwordTextField = CustomUITextField()
    let newPasswordTextField = CustomUITextField()
    let confirmNewPasswordTextField = CustomUITextField()
    
    let changePasswordButton = CustomUIButton()
    
    func setupView() {
        
        self.backgroundColor = .white
        
        addSubview(passwordTextField)
        passwordTextField.placeholder = "비밀번호"
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        
        addSubview(newPasswordTextField)
        newPasswordTextField.placeholder = "새로운 비밀번호"
        newPasswordTextField.autocapitalizationType = .none
        newPasswordTextField.isSecureTextEntry = true
        
        addSubview(confirmNewPasswordTextField)
        confirmNewPasswordTextField.placeholder = "새로운 비밀번호 확인"
        confirmNewPasswordTextField.autocapitalizationType = .none
        confirmNewPasswordTextField.isSecureTextEntry = true
        
        addSubview(changePasswordButton)
        changePasswordButton.setTitle("변경하기", for: .normal)
        changePasswordButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .heavy)
        changePasswordButton.backgroundColor = .lightGray
                
    }
    
    func setupConstraints() {
   
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }

        newPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.centerX.equalTo(passwordTextField.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }

        confirmNewPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(10)
            make.centerX.equalTo(newPasswordTextField.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }

        changePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(confirmNewPasswordTextField.snp.bottom).offset(10)
            make.centerX.equalTo(confirmNewPasswordTextField.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
    }
}
