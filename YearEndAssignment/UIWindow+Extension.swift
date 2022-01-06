
import UIKit

extension UIWindow {
    
    func changeRootViewControllerWithAnimation(duration: CGFloat, options: UIView.AnimationOptions, rootViewController: UIViewController) {
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            self.rootViewController = UINavigationController(rootViewController: rootViewController)
            self.makeKeyAndVisible()
        }, completion: nil)
    }
}
