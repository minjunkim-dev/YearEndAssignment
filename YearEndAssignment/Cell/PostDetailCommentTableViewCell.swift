
import UIKit

import SnapKit

class PostDetailCommentTableViewCell: UITableViewCell {

    let usernameLabel = UILabel()
    let contentLabel = UILabel()
    let commentWriteEditButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(username: String, content: String) {
        
        setupView()
        setupConstraints()
        
        usernameLabel.text = username
        contentLabel.text = content
    }

    func setupView() {
        
        addSubview(usernameLabel)
        usernameLabel.backgroundColor = .lightGray
        usernameLabel.numberOfLines = 1
        usernameLabel.sizeToFit()
        
        addSubview(contentLabel)
        contentLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        contentLabel.numberOfLines = 0
        contentLabel.sizeToFit()

    
    }
    
    func setupConstraints() {
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(10)
            make.trailing.lessThanOrEqualTo(safeAreaLayoutGuide.snp.trailing).inset(10)
        }
    
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.leading.equalTo(usernameLabel.snp.leading)
            make.trailing.lessThanOrEqualTo(safeAreaLayoutGuide.snp.trailing).inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        
    }
}
