
import UIKit

import Toast

extension ToastManager {
    
    static var customStyle: ToastStyle {
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
}
