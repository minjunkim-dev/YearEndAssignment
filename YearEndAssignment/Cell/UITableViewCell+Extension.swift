
import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: ReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
