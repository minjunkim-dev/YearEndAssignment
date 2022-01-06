
import UIKit

extension UIViewController {
 
    func showAlert(title: String, message: String, okTitle: String, okCompletion: (() -> Void)?, cancleTitle: String?, cancleCompletion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let cancleTitle = cancleTitle {
            let cancleAction = UIAlertAction(title: cancleTitle, style: .destructive) { _ in
                
                if let cancleCompletion = cancleCompletion {
                    cancleCompletion()
                }
            }
            alert.addAction(cancleAction)
        }
        let okAction = UIAlertAction(title: okTitle, style: .cancel) { _ in
            
            if let okCompletion = okCompletion {
                okCompletion()
            }
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
