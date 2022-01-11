
import UIKit

class PostViewController: UIViewController {
    
    let mainView = PostView()
    var viewModel = PostViewModel()
    
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

    }
    
    @objc func pullToRefreshPost() {
        viewModel.getUserPost { error in
            
            if let error = error {
                dump(error)
                return
            }
        
            self.mainView.tableView.reloadData()
            self.mainView.tableView.refreshControl?.endRefreshing()
        }
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
            if vc.mainView.textView.text != "" {
                vc.viewModel.postUserPost { error in
                    if let error = error {
                        dump(error)
                        return
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            }
            else {
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
