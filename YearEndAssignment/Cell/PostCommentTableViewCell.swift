
import UIKit

import SnapKit

class PostCommentTableViewCell: UITableViewCell {
    
    let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     
    }
    
    func configureCell(commentTitle: String) {
        
        setupView()
        setupConstraints()
        
        commentButton.setTitle("  \(commentTitle)", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        
        addSubview(commentButton)
        
    }
    
    func setupConstraints() {
        
        commentButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(10)
        }
        
    }

}

