
import UIKit

class CommentWriteEditViewController: UIViewController {

    let mainView = CommentWriteEditView()
    var viewModel = PostViewModel()
    
    var doneButton: UIBarButtonItem!
    
    var completionHandler: (() -> Void)?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        setCenterAlignedNavigationItemTitle(text: "새싹농장 댓글쓰기", size: 18, color: .black, weight: .heavy)
        
        doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonClicked))
        navigationItem.rightBarButtonItems = [doneButton]
        
        mainView.textView.delegate = self
        mainView.textView.becomeFirstResponder()
        viewModel.writeEditText.bind { text in
            self.mainView.textView.text = text
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    
    @objc func doneButtonClicked() {
        
        completionHandler?()
    
    }
    
}

extension CommentWriteEditViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        viewModel.writeEditText.value = textView.text
    }
}
