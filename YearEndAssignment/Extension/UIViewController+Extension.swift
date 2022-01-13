import UIKit

import Toast

extension UIViewController {
    
    func showAlert(title: String?, message: String?, okTitle: String, okCompletion: (() -> Void)?, cancleTitle: String?, cancleCompletion: (() -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let cancleTitle = cancleTitle {
            let cancleAction = UIAlertAction(title: cancleTitle, style: .destructive) { _ in
             
                cancleCompletion?()
            }
            alert.addAction(cancleAction)
        }
        
        let okAction = UIAlertAction(title: okTitle, style: .cancel) { _ in
            
            okCompletion?()
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showActionSheet(title: String?, message: String?, editTitle: String, editCompletion: (() -> Void)?, deleteTitle: String, deleteCompletion: (() -> Void)?, cancleTitle: String?, cancleCompletion: (() -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        if let cancleTitle = cancleTitle {
            let cancleAction = UIAlertAction(title: cancleTitle, style: .cancel) { _ in
                
                cancleCompletion?()
            }
            alert.addAction(cancleAction)
        }
        
        let editAction = UIAlertAction(title: editTitle, style: .default) { _ in
            
            editCompletion?()
        }
        alert.addAction(editAction)
        
        let deleteAction = UIAlertAction(title: deleteTitle, style: .destructive) { _ in
            
            deleteCompletion?()
        }
        alert.addAction(deleteAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    var style: ToastStyle {
        get {
            
            ToastManager.shared.isTapToDismissEnabled = true
            ToastManager.shared.isQueueEnabled = false
            
            var style = ToastStyle()
            style.cornerRadius = 10
            style.titleAlignment = .center
            style.messageAlignment = .center
            style.backgroundColor = UIColor.darkGray
            
            return style
        }
    }

    func setLeftAlignedNavigationItemTitle(text: String, size: CGFloat,
                                           color: UIColor, weight: UIFont.Weight)
    {
        
        let titleLabel = UILabel()
        titleLabel.textColor = color
        titleLabel.text = text
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: size, weight: weight)
        
        let spacer = UIView()
        let constraint = spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat.greatestFiniteMagnitude)
        constraint.isActive = true
        constraint.priority = .defaultLow
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, spacer])
        stack.axis = .horizontal
        self.navigationItem.titleView = stack
    }
    
    func setCenterAlignedNavigationItemTitle(text: String, size: CGFloat,
                                           color: UIColor, weight: UIFont.Weight)
    {
      
        let titleLabel = UILabel()
        titleLabel.textColor = color
        titleLabel.text = text
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: size, weight: weight)
        
        self.navigationItem.titleView = titleLabel
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
