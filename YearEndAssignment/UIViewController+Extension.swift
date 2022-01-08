import UIKit

extension UIViewController
{
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
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: size, weight: weight)
        
        self.navigationItem.titleView = titleLabel
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
