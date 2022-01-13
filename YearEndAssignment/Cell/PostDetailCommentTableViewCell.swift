
import UIKit

import SnapKit

import Toast

class PostDetailCommentTableViewCell: UITableViewCell {

    let usernameLabel = UILabel()
    let contentLabel = UILabel()
   
    var identifier: String?  // user's identifier
    var comment: CommentDetail?
    
    let editDeleteButton: UIButton = {
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
    
    
    @objc func checkAuthorizationOnComment() {
        
        print(#function)
        
        if self.identifier != UserDefaults.standard.string(forKey: "identifier") {
            
            let title = "댓글 수정 및 삭제 불가"
            let message = "내가 작성한 댓글이 아닙니다."
            
            self.contentView.hideAllToasts()
            self.contentView.makeToast(message, duration: 3.0, position: .center, title: title, style: ToastManager.customStyle)
            
        } else {
            
            guard let rootVC = findViewController() as? PostDetailViewController else { return }
            
            rootVC.viewModel.comment = self.comment
            rootVC.showActionSheet(title: nil, message: nil, editTitle: "댓글 수정", editCompletion: {
                let vc = CommentWriteEditViewController()

                vc.viewModel.writeEditText.value = self.contentLabel.text ?? ""
                vc.completionHandler = {
                    rootVC.viewModel.writeEditText.value = vc.viewModel.writeEditText.value
                    rootVC.viewModel.putUserComment { error in
                        if let error = error {
                            dump(error)
                            return
                        }
                        vc.navigationController?.popViewController(animated: true)
                     
                        
                        rootVC.mainView.writeCommentButton.makeToast("댓글을 수정했어요", duration: 3.0, position: .center, title: nil, style: ToastManager.customStyle)
                        
                        rootVC.reloadView()
                    }
                }
                
                
                rootVC.navigationController?.pushViewController(vc, animated: true)
            }, deleteTitle: "댓글 삭제", deleteCompletion: {
               
                rootVC.viewModel.deleteUserComment { error in
                    if let error = error {
                        dump(error)
                        return
                    }
                    

                    rootVC.mainView.writeCommentButton.makeToast("댓글을 삭제했어요", duration: 3.0, position: .center, title: nil, style: ToastManager.customStyle)
                    
                    rootVC.reloadView()
                }
                    
                
                    
            
            
            }, cancleTitle: "취소", cancleCompletion: nil)
        }
    }
    
    func configureCell(comment: CommentDetail) {
        
        usernameLabel.text = comment.user.username
        contentLabel.text = comment.comment
        self.identifier = comment.user.email
        self.comment = comment
    
        setupView()
        setupConstraints()
        
    }

    func setupView() {
        
        /*
         셀에 있는 컨텐트 뷰에 올려놔야 정상 동작하는듯...
         코멘트 버튼이 계속 리로드 전에는 안눌리는 버그 때문에 발견함...
         */
        self.contentView.addSubview(usernameLabel)
        usernameLabel.numberOfLines = 1
        usernameLabel.sizeToFit()
        
        self.contentView.addSubview(contentLabel)
        contentLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        contentLabel.numberOfLines = 0
        contentLabel.sizeToFit()


        self.contentView.addSubview(editDeleteButton)

        editDeleteButton.addTarget(self, action: #selector(checkAuthorizationOnComment), for: .touchUpInside)
        
    }
    
    func setupConstraints() {
        
        self.contentView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top).inset(10)
            make.leading.equalTo(self.contentView.snp.leading).inset(10)
            make.trailing.lessThanOrEqualTo(editDeleteButton.snp.leading).inset(10)
        }
        
        editDeleteButton.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.top)
            make.trailing.equalTo(self.contentView.snp.trailing).inset(10)
            make.size.equalTo(25)
        }
    
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.leading.equalTo(usernameLabel.snp.leading)
            make.trailing.lessThanOrEqualTo(self.contentView.snp.trailing).inset(10)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
        }
        
    }
}
