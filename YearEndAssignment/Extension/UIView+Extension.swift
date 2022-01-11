
import UIKit

extension UIView {
    
    func getViewForFooterInSection(width: CGFloat, height: CGFloat, color: UIColor) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        view.backgroundColor = color
        return view
    }
}
