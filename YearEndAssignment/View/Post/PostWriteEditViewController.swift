
import UIKit

class PostWriteEditViewController: UIViewController {

    let mainView = PostWriteEditView()
    var viewModel = PostViewModel()

    var closeButton: UIBarButtonItem!
    var doneButton: UIBarButtonItem!
    
    var handler: (() -> Void)?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setCenterAlignedNavigationItemTitle(text: viewModel.navTitle, size: 18, color: .black, weight: .heavy)

        closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeButtonClicked))
        doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonClicked))
        
        navigationItem.leftBarButtonItems = [closeButton]
        navigationItem.rightBarButtonItems = [doneButton]
        
        viewModel.text.bind { text in
            self.mainView.textView.text = text
        }
        
        mainView.textView.delegate = self
        
        mainView.textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mainView.textView.resignFirstResponder()
    }
    
    @objc func closeButtonClicked() {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func doneButtonClicked() {
        
        if viewModel.navTitle == "새싹농장 글쓰기" {
            if mainView.textView.text != "" {
                viewModel.postUserPost { error in
                    if let error = error {
                        dump(error)
                        return
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            }
            self.dismiss(animated: true, completion: nil)
        } else {
            viewModel.putUserPost { error in
                if let error = error {
                    dump(error)
                    return
                }
                self.handler?()
                self.dismiss(animated: true, completion: nil)
            }
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
}

extension PostWriteEditViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.text.value = textView.text ?? ""
    }
}

