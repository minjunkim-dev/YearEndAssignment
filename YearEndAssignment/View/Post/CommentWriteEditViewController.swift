
import UIKit

class CommentWriteEditViewController: UIViewController {

    let mainView = CommentWriteEditView()
    var viewModel = PostViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.backButtonTitle = ""
    }
    
}

