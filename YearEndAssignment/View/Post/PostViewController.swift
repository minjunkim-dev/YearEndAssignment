
import UIKit

class PostViewController: UIViewController {
    
    let mainView = PostView()
    var viewModel = PostViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        print(String(describing: type(of: self)), #function)
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
    
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        
        mainView.tableView.refreshControl = UIRefreshControl()
        mainView.tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
                
        mainView.writeButton.addTarget(self, action: #selector(writeButtonClicked), for: .touchUpInside)
        
        viewModel.getUserPost { error in

            if let error = error {
                dump(error)
                return
            }

            self.mainView.tableView.reloadData()
        }
    }
    
    @objc func pullToRefresh() {
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
        
        print(String(describing: type(of: self)), #function)
        self.setLeftAlignedNavigationItemTitle(text: "새싹농장", size: 25, color: .black, weight: .heavy, margin: 20)
        
        
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
        vc.viewModel.navTitle = "새싹농장 글쓰기"
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .coverVertical
        present(nav, animated: true, completion: nil)
    }
}


extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRowAt(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightOfRowAt
    }

//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return viewModel.viewForFooterInSection(tableView, viewForFooterInSection: section)
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return viewModel.heightForFooterInSection(tableView, heightForFooterInSection: section)
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = self.viewModel.posts[indexPath.section]
        
        let vc = PostDetailViewController()
        vc.viewModel.post = row
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
