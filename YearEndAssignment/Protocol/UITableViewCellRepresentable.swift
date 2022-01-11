
import Foundation
import UIKit

@objc protocol UITableViewCellRepresentable {
    
    var numberOfSection: Int { get }
    var numberOfRowsInSection: Int { get }
    var heightOfRowAt: CGFloat { get }
    func postCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    
    func commentCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    
    @objc optional func viewForHeaderInSeciton(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    @objc optional func heightForHeaderInSection(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    
    @objc optional func viewForFooterInSection(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    @objc optional func heightForFooterInSection(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    
    @objc optional func didSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}
