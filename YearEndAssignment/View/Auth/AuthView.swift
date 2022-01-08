
import UIKit

import SnapKit

class AuthView: UIView, ViewPresentable {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "logo_ssac_clear")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let summaryStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    let signupButton = AuthUIButton()
    
    let signinLabel = UILabel()
    let signinButton = AuthUIButton()
    let signinStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .fillProportionally
        return stack
    }()
    
    func setupView() {
        
        self.backgroundColor = .white
        
        addSubview(logoImageView)
        
        
        summaryStack.addArrangedSubview(titleLabel)
        titleLabel.text = "당신 근처의 새싹농장"
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        titleLabel.numberOfLines = 1
        titleLabel.sizeToFit()
        
        
        summaryStack.addArrangedSubview(subtitleLabel)
        subtitleLabel.text =
        """
        iOS 지식부터 바람의 나라까지
        지금 SeSAC에서 함께해보세요!
        """
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        subtitleLabel.numberOfLines = 2
        subtitleLabel.sizeToFit()
        
        
        addSubview(summaryStack)
     
     
        addSubview(signupButton)
        signupButton.setTitle("가입하기", for: .normal)
        signupButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .heavy)
        
        
        signinStack.addArrangedSubview(signinLabel)
        signinLabel.text = "이미 계정이 있나요?"
        signinLabel.font = .systemFont(ofSize: 16, weight: .heavy)
        signinLabel.textAlignment = .center
        signinLabel.textColor = .systemGray
        signinLabel.sizeToFit()
        
        
        signinStack.addArrangedSubview(signinButton)
        signinButton.setTitle("시작하기", for: .normal)
        signinButton.setTitleColor(.systemGreen, for: .normal)
        signinButton.backgroundColor = .clear
        signinButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .heavy)

        
        addSubview(signinStack)
        
    }
    
    func setupConstraints() {
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.8)
            make.size.equalTo(self.snp.width).multipliedBy(0.4)
        }
        
        summaryStack.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(10)
            make.centerX.equalTo(logoImageView.snp.centerX)
        }
        
        signinStack.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
        }
        
        signupButton.snp.makeConstraints { make in
            make.bottom.equalTo(signinStack.snp.top).offset(-10)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
    }
}
