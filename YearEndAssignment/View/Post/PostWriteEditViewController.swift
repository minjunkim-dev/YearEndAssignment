
import UIKit

class PostWriteEditViewController: UIViewController {

    let mainView = PostWriteEditView()
    var viewModel = PostViewModel()

    var closeButton: UIBarButtonItem!
    var doneButton: UIBarButtonItem!
    
    var completionHandler: (() -> Void)?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        setCenterAlignedNavigationItemTitle(text: "새싹농장 글쓰기", size: 18, color: .black, weight: .heavy)

        closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeButtonClicked))
        doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonClicked))
        navigationItem.leftBarButtonItems = [closeButton]
        navigationItem.rightBarButtonItems = [doneButton]
        
        
        mainView.textView.delegate = self
        viewModel.writeEditText.bind { text in
            self.mainView.textView.text = text
        }
        
        mainView.textView.becomeFirstResponder()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainView.textView.resignFirstResponder()
    }
    
    @objc func closeButtonClicked() {
    
        dismiss(animated: true, completion: nil)
    }
    
    @objc func doneButtonClicked() {
       
        self.completionHandler?()
    }
}

extension PostWriteEditViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.writeEditText.value = textView.text ?? ""
    }
}

