
import UIKit

class PostDetailViewController: UIViewController {
    
    var viewModel = PostViewModel()
    let mainView = PostDetailView()
    
    var editDeleteButton: UIBarButtonItem!
    var menuItems: [UIAction] {
        return [
            UIAction(title: "게시글 수정", image: UIImage(systemName: "pencil"), handler: { _ in
                let vc = PostWriteEditViewController()
                vc.viewModel.navTitle = "새싹농장 글수정"
                vc.viewModel.text.value = self.mainView.contentLabel.text ?? ""
                vc.viewModel.post = self.viewModel.post
                vc.handler = {
                    self.viewModel.post = vc.viewModel.post
                    self.mainView.configurePost(username: self.viewModel.post?.user.username ?? "", date: self.viewModel.post?.updatedAt ?? "", content: self.viewModel.post?.text ?? "", commentCount: self.viewModel.post?.comments.count ?? 0)
                }
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                nav.modalTransitionStyle = .coverVertical
                self.present(nav, animated: true, completion: nil)
            }),
            UIAction(title: "게시글 삭제", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { _ in
                self.viewModel.deleteUserPost { error in
                    if let error = error {
                        dump(error)
                        return
                    }
                    
                    self.navigationController?.popViewController(animated: true)
                }
            })
        ]
    }
    
    var menu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
    }
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        
        editDeleteButton = UIBarButtonItem(title: "", image: UIImage(systemName: "ellipsis.circle"), primaryAction: nil, menu: menu)
        navigationItem.rightBarButtonItems = [editDeleteButton]
        
        
        mainView.commentTextField.addTarget(self, action: #selector(commentTextFieldClicked(_:)), for: .touchDown)
        
        
        
        
        mainView.tableView.refreshControl = UIRefreshControl()
        mainView.tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
    }
    
    @objc func pullToRefresh() {
        
        viewModel.getUserComment { error in
            
            if let error = error {
                dump(error)
                return
            }
            
            self.mainView.tableView.reloadData()
            self.mainView.tableView.refreshControl?.endRefreshing()
        }
    }
    
    
    @objc func commentTextFieldClicked(_ textfield: UITextField) {
        mainView.commentTextField.resignFirstResponder()
        let vc = CommentWriteEditViewController()
        vc.viewModel.post = self.viewModel.post
        vc.viewModel.navTitle = "댓글 쓰기"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(String(describing: type(of: self)), #function)
        
        print(viewModel.post?.id)
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailCommentTableViewCell.reuseIdentifier, for: indexPath) as? PostDetailCommentTableViewCell else { return UITableViewCell() }
        
        if viewModel.comments.count > 0 {
            let row = viewModel.comments[indexPath.row]
            let username = row.user.username
            let content = row.comment
            cell.configureCell(username: username, content: content)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightOfRowAt
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
