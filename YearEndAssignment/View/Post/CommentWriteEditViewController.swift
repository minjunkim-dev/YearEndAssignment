
import UIKit

class CommentWriteEditViewController: UIViewController {

    let mainView = CommentWriteEditView()
    var viewModel = PostViewModel()
    
    var doneButton: UIBarButtonItem!
    
    var handler: (() -> Void)?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        setCenterAlignedNavigationItemTitle(text: "새싹농장 댓글쓰기", size: 18, color: .black, weight: .heavy)
        
        doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonClicked))
        navigationItem.rightBarButtonItems = [doneButton]
        
        mainView.textView.becomeFirstResponder()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func doneButtonClicked() {
        
        if mainView.textView.text != "" {
            viewModel.writeEditText.value = self.mainView.textView.text
            print(viewModel.writeEditText.value)
            viewModel.postUserComment { error in
                if let error = error {
                    dump(error)
                    return
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
        self.navigationController?.popViewController(animated: true)
    
    }
    
}
