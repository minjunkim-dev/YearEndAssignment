
import UIKit

import SnapKit

class PostDetailView: UIView, ViewPresentable {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    let usernameLabel = UILabel()
    let dateLabel = UILabel()
    let contentLabel = UILabel()
    
    let profileStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fillEqually
        return stack
    }()
    let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let tableView = UITableView()
    
    let commentTextField: AuthUITextField = {
        let textField = AuthUITextField()
        let placeholder = "댓글을 입력해주세요"
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        textField.backgroundColor = .lightGray
        textField.layer.cornerRadius = 20
        textField.borderWidth = 0
        
        return textField
    }()
    
    
    let separator: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 10))
        view.backgroundColor = .lightGray
        return view
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        setupView()
        setupConstraints()
    }
    
    func configurePost(username: String, date: String, content: String, commentCount: Int) {
        usernameLabel.text = username
        dateLabel.text = date
        contentLabel.text = content
        
        let commentTitle = commentCount != 0 ? "  댓글 \(commentCount)": "  댓글쓰기"
        commentButton.setTitle(commentTitle, for: .normal)
    }
    
    func setupView() {
        
        self.backgroundColor = .white
        
        addSubview(profileImageView)
        
        profileStack.addArrangedSubview(usernameLabel)
        usernameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        usernameLabel.numberOfLines = 1
        usernameLabel.sizeToFit()
        
        profileStack.addArrangedSubview(dateLabel)
        dateLabel.sizeToFit()
        
        addSubview(profileStack)

    
        addSubview(contentLabel)
        contentLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        contentLabel.numberOfLines = 0
        contentLabel.sizeToFit()
        addSubview(commentButton)


        addSubview(tableView)
        tableView.register(PostDetailCommentTableViewCell.self, forCellReuseIdentifier: PostDetailCommentTableViewCell.reuseIdentifier)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100

        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        tableView.separatorInset = .zero

        tableView.sectionHeaderTopPadding = 0
        tableView.sectionHeaderHeight = 0


        addSubview(commentTextField)
        
    }
    
    func setupConstraints() {
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(10)
            make.size.equalTo(50)
        }
        
        profileStack.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.centerY.equalTo(profileImageView)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(10)
            make.height.equalTo(profileImageView.snp.height)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(profileStack.snp.bottom).offset(20)
            make.leading.equalTo(profileImageView.snp.leading)
            make.trailing.lessThanOrEqualTo(safeAreaLayoutGuide.snp.trailing).inset(10)
            make.bottom.lessThanOrEqualTo(commentButton.snp.top)
        }
        
        commentButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom)
            make.leading.equalTo(profileImageView.snp.leading)
            make.height.equalTo(50)
        }
                
        commentTextField.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(commentButton.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(commentTextField.snp.top).offset(-10)
        }
    }
}
