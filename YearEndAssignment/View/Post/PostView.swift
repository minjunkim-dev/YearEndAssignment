
import UIKit

import SnapKit

class PostView: UIView, ViewPresentable {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
    let writeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        
        let size = UIScreen.main.bounds.width / 6
        button.frame = .init(x: 0, y: 0, width: size, height: size)
    
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration.init(pointSize: size, weight: UIImage.SymbolWeight.light), forImageIn: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        button.layer.cornerRadius = button.bounds.size.width / 2
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        
        return button
    }()
    
    func setupView() {
        
        self.backgroundColor = .white
        
        addSubview(tableView)
        tableView.register(PostContentTableViewCell.self, forCellReuseIdentifier: PostContentTableViewCell.reuseIdentifier)
        tableView.register(PostCommentTableViewCell.self, forCellReuseIdentifier: PostCommentTableViewCell.reuseIdentifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .systemGray3
        tableView.separatorInset = .zero
        
        tableView.sectionHeaderTopPadding = 0
        tableView.sectionHeaderHeight = 0
        
        addSubview(writeButton)
        
    }
    
    func setupConstraints() {
   
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        writeButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(20)
        }
    }
}
