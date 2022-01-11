
import UIKit

import SnapKit

class PostDetailView: UIView, ViewPresentable {
    
    
    let postDetailSeparators = [UIView(), UIView(), UIView()]

    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.tintColor = .systemGray3
        return imageView
    }()
    let usernameLabel = UILabel()
    let dateLabel = UILabel()
    let profileStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    
    
    let contentTextView = UITextView()
    

    let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        return button
    }()

    
    
    
    
    
    let tableView = UITableView()

    
    let writeCommentButton: CustomUIButton = {
        let button = CustomUIButton()
        let text = "댓글을 입력해주세요"
        
        button.setTitle(text, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        button.backgroundColor = .systemGray3
        button.layer.cornerRadius = 20
        return button
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
        dateLabel.text = DateFormatter().getGmtToLocalDate(gmt: date)
        contentTextView.text = content
        
        let margin = "  "
        let commentTitle = commentCount != 0 ? margin + "댓글 \(commentCount)": margin + "댓글쓰기"
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
        
        
        
        postDetailSeparators.forEach { separator in
            addSubview(separator)
            separator.backgroundColor = .systemGray5
        }

    
        addSubview(contentTextView)
        contentTextView.font = .systemFont(ofSize: 18, weight: .semibold)
        contentTextView.isEditable = false
        
        
        
        
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


        addSubview(writeCommentButton)
        
    }
    
    func setupConstraints() {
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(10)
            make.size.equalTo(50)
        }
        
        profileStack.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.centerY.equalTo(profileImageView)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(10)
            make.height.equalTo(profileImageView.snp.height)
        }
        
        
        postDetailSeparators[0].snp.makeConstraints { make in
            make.top.equalTo(profileStack.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        

        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(postDetailSeparators[0].snp.bottom).offset(10)
            make.leading.equalTo(profileImageView.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(10)
            make.height.equalTo(UIScreen.main.bounds.height / 5)
        }

        
        postDetailSeparators[1].snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        commentButton.snp.makeConstraints { make in
            make.top.equalTo(postDetailSeparators[1].snp.bottom)
            make.leading.equalTo(profileImageView.snp.leading)
            make.height.equalTo(44)
        }
                
        writeCommentButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(44)
        }
        
        postDetailSeparators[2].snp.makeConstraints { make in
            make.top.equalTo(commentButton.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(postDetailSeparators[2].snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(writeCommentButton.snp.top).offset(-10)
        }
    }
}
