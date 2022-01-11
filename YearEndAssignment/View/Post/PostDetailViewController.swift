
import UIKit

import Toast

class PostDetailViewController: UIViewController {
    
    var viewModel = PostViewModel()
    let mainView = PostDetailView()

    var editDeleteButton: UIBarButtonItem!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        editDeleteButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .done, target: self, action: #selector(checkAuthorization))
        navigationItem.rightBarButtonItems = [editDeleteButton]

        
        mainView.writeCommentButton.addTarget(self, action: #selector(writeCommentButtonClicked), for: .touchDown)
        
        mainView.tableView.refreshControl = UIRefreshControl()
        mainView.tableView.refreshControl?.addTarget(self, action: #selector(pullToRefreshComment), for: .valueChanged)
    }
    
    @objc func checkAuthorization() {
        print(#function)
        if viewModel.post?.user.email != UserDefaults.standard.string(forKey: "identifier") {
            
            let title = "글 수정 및 삭제 불가"
            let message = "내가 작성한 글이 아닙니다."
            
            self.view.makeToast(message, duration: 3.0, position: .center, title: title, style: style)
            
        } else {
            
            self.showActionSheet(title: nil, message: nil, editTitle: "글 수정", editCompletion: {
                let vc = PostWriteEditViewController()
                
                // 수정할 텍스트 전달
                vc.viewModel.writeEditText.value = self.viewModel.post?.text ?? ""
                
                // 수정이 끝나면 API를 통해 포스트를 수정
                vc.completionHandler = {
                    self.viewModel.writeEditText.value = vc.viewModel.writeEditText.value
                    self.viewModel.putUserPost { error in
                        if let error = error {
                            dump(error)
                            return
                        }
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                nav.modalTransitionStyle = .coverVertical
                self.present(nav, animated: true, completion: nil)
            }, deleteTitle: "글 삭제", deleteCompletion: {
                self.viewModel.deleteUserPost { error in
                    if let error = error {
                        dump(error)
                        return
                    }
                    
                    self.navigationController?.popViewController(animated: true)
                }
            }, cancleTitle: "취소", cancleCompletion: nil)
        }
    }
    
    @objc func pullToRefreshComment() {
        
        viewModel.getUserComment { error in
            
            if let error = error {
                dump(error)
                return
            }
            
            self.mainView.tableView.reloadData()
            self.mainView.tableView.refreshControl?.endRefreshing()
        }
    }
    
    
    @objc func writeCommentButtonClicked() {
    
        let vc = CommentWriteEditViewController()
        vc.viewModel.post = self.viewModel.post
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getUserPost { error in
            
            if let error = error {
                dump(error)
                return
            }
            
            self.mainView.configurePost(username: self.viewModel.post?.user.username ?? "", date: self.viewModel.post?.updatedAt ?? "", content: self.viewModel.post?.text ?? "", commentCount: self.viewModel.post?.comments.count ?? 0)
            
            self.viewModel.getUserComment { error in
                
                if let error = error {
                    dump(error)
                    return
                }
                
                self.mainView.tableView.reloadData()
            }
        }
    }
}



extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return viewModel.commentCellForRowAt(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightOfRowAt
    }
}
