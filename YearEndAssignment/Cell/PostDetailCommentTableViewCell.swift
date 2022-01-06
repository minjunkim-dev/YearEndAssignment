
import UIKit

import SnapKit

class PostDetailCommentTableViewCell: UITableViewCell {

    let usernameLabel = UILabel()
    let contentLabel = UILabel()
    let commentWriteEditButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    
    
    
    var menuItems: [UIAction] {
        return [
            UIAction(title: "댓글 수정", image: UIImage(systemName: "pencil"), handler: { _ in
                let vc = CommentWriteEditViewController()
                vc.viewModel.navTitle = "댓글 수정"
                vc.viewModel.text.value = self.contentLabel.text ?? ""
                vc.handler = {
                  
                }
                
                // push vc
                
            }),
            UIAction(title: "댓글 삭제", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { _ in
            
                PostViewModel().deleteUserComment { error in
                    if let error = error {
                        dump(error)
                        return
                    }
                    
                // required reload!
                    
                }
            })
        ]
    }
    
    var menu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
    }
    
    var editDeleteButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 25, weight: .regular), forImageIn: .normal)
        button.tintColor = .black
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
        usernameLabel.numberOfLines = 1
        usernameLabel.sizeToFit()
        
        addSubview(contentLabel)
        contentLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        contentLabel.numberOfLines = 0
        contentLabel.sizeToFit()

        
        addSubview(editDeleteButton)
        editDeleteButton.menu = menu
        editDeleteButton.showsMenuAsPrimaryAction = true
        editDeleteButton.isUserInteractionEnabled = true
        editDeleteButton.isEnabled = true
        

    }
    
    func setupConstraints() {
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(10)
            make.trailing.lessThanOrEqualTo(editDeleteButton.snp.leading).inset(10)
        }
        
        editDeleteButton.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.top)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(20)
            make.size.equalTo(25)
        }
    
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.leading.equalTo(usernameLabel.snp.leading)
            make.trailing.lessThanOrEqualTo(safeAreaLayoutGuide.snp.trailing).inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        
    }
}
