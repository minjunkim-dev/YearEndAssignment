
import UIKit

class PostViewController: UIViewController {
    
    let mainView = PostView()
    var viewModel = PostViewModel()
    
    var changePasswordButton: UIBarButtonItem!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
    
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.tableView.refreshControl = UIRefreshControl()
        mainView.tableView.refreshControl?.addTarget(self, action: #selector(pullToRefreshPost), for: .valueChanged)
        
        mainView.writeButton.addTarget(self, action: #selector(writeButtonClicked), for: .touchUpInside)

        changePasswordButton = UIBarButtonItem(title: "비밀번호 변경", style: .done, target: self, action: #selector(changePasswordButtonClicked))
        
        /* 비밀번호 변경 에러를 아직 못잡음... */
//        navigationItem.rightBarButtonItems = [changePasswordButton]
        
    }
    
    @objc func pullToRefreshPost() {
        viewModel.getUserPost { error in
            
            if let error = error {
                dump(error)
                return
            }
        
            self.mainView.tableView.refreshControl?.beginRefreshing()
            self.mainView.tableView.reloadData()
            self.mainView.tableView.refreshControl?.endRefreshing()
        }
    }
    
    @objc func changePasswordButtonClicked() {
        
        let vc = ChangePasswordViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setLeftAlignedNavigationItemTitle(text: "새싹농장", size: 25, color: .black, weight: .heavy)
        
        viewModel.getUserPost { error in

            if let error = error {
                dump(error)
                return
            }

            self.mainView.tableView.reloadData()
        }
    }

    @objc func writeButtonClicked() {
        let vc = PostWriteEditViewController()

        vc.completionHandler = {
            
            self.viewModel.writeEditText.value = vc.viewModel.writeEditText.value
            self.viewModel.postUserPost { error in
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
        present(nav, animated: true, completion: nil)
    }
}


extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.postCellForRowAt(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return viewModel.heightOfRowAt
        
        if indexPath.row == 0 { // content
            return UIScreen.main.bounds.height / 4
        } else { // comment
            return 44
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = self.viewModel.posts[indexPath.section]

        let vc = PostDetailViewController()
        vc.viewModel.post = row // 클릭된 포스트의 정보를 전달
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
