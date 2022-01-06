import UIKit

extension UIViewController
{
    func setLeftAlignedNavigationItemTitle(text: String, size: CGFloat,
                                           color: UIColor, weight: UIFont.Weight,
                                           margin left: CGFloat)
    {
        let titleLabel = UILabel()
        titleLabel.textColor = color
        titleLabel.text = text
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: size, weight: weight)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.navigationItem.titleView = titleLabel
        
        guard let containerView = self.navigationItem.titleView?.superview else { return }
        
        let leftBarItemWidth = self.navigationItem.leftBarButtonItems?.reduce(0, { $0 + $1.width })
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor,
                                             constant: (leftBarItemWidth ?? 0) + left),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        ])
    }
    
    func setCenterAlignedNavigationItemTitle(text: String, size: CGFloat,
                                           color: UIColor, weight: UIFont.Weight)
    {
        let titleLabel = UILabel()
        titleLabel.textColor = color
        titleLabel.text = text
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: size, weight: weight)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.navigationItem.titleView = titleLabel
        
        guard let containerView = self.navigationItem.titleView?.superview else { return }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        ])
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
