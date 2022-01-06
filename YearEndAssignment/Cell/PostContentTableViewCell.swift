
import UIKit

import SnapKit

class PostContentTableViewCell: UITableViewCell {

    let usernameLabel = UILabel()
    let contentLabel = UILabel()
    let dateLabel = UILabel()
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     
    }
    
    func configureCell(username: String, content: String, date: String) {
        
        setupView()
        setupConstraints()
        
        usernameLabel.text = username
        contentLabel.text = content
        dateLabel.text = date // 로컬라이징 필요!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        
        addSubview(usernameLabel)
        usernameLabel.numberOfLines = 1
        usernameLabel.sizeToFit()
        
        addSubview(contentLabel)
        contentLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        contentLabel.numberOfLines = 0
        contentLabel.sizeToFit()
        
        addSubview(dateLabel)
        dateLabel.sizeToFit()
    
    }
    
    func setupConstraints() {
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(10)
            make.trailing.lessThanOrEqualTo(safeAreaLayoutGuide.snp.trailing).inset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
            make.leading.equalTo(usernameLabel.snp.leading)
            make.trailing.lessThanOrEqualTo(safeAreaLayoutGuide.snp.trailing).inset(10)
        }
                
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(20)
            make.leading.equalTo(usernameLabel.snp.leading)
            make.trailing.lessThanOrEqualTo(safeAreaLayoutGuide.snp.trailing).inset(10)
            make.bottom.lessThanOrEqualTo(dateLabel.snp.top).offset(-20)
        }
        
    }
}

