
import UIKit

class PostViewModel {
    
    var posts: [Post] = []
    var post: Post?
    var text: Observable<String> = Observable("")
    var navTitle: String = ""
    
    func getUserPost(completion: @escaping (APIError?) -> Void) {
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.getContent(token: token) { data, error in
          
            if let data = data {
                print("GET post 성공!")
                self.posts = data
                completion(nil)
            } else {
                print("GET post 실패!")
                dump(error)
                completion(error)
            }
        }
    }
    
    func postUserPost(completion: @escaping (APIError?) -> Void) {
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.postContent(token: token, text: text.value) { data, error in
            if let data = data {
                print("POST post 성공!")
//                dump(data)
                self.posts = [data]
                print(self.posts.first?.id)
                completion(nil)
            } else {
                print("POST post 실패!")
                dump(error)
                completion(error)
            }
        }
    }
    
    func putUserPost(completion: @escaping (APIError?) -> Void) {
        
        guard let postId = post?.id else { return }
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.putContent(token: token, text: text.value, postId: postId) { data, error in
            if let data = data {
                print("PUT post 성공!")
//                dump(data)
                self.post = data
                completion(nil)
            } else {
                print("PUT post 실패!")
                dump(error)
                completion(error)
            }
        }
    }
    
    func deleteUserPost(completion: @escaping (APIError?) -> Void) {
        
        guard let postId = post?.id else { return }
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.deleteContent(token: token, postId: postId) { data, error in
            if let data = data {
                print("DELETE post 성공!")
//                dump(data)
                self.post = data
                completion(nil)
            } else {
                print("DELETE post 실패!")
                dump(error)
                completion(error)
            }
        }
    }
    
    func getUserComment() {
        
    }
    
    func postUserComment() {
        
    }
    
    func putUserComment() {
        
    }
    
    func deleteUserComment() {
        
    }
}

extension PostViewModel: UITableViewCellRepresentable {
    
    var numberOfSection: Int {
        return posts.count
    }
    
    var numberOfRowsInSection: Int {
        return 2 // content + comment
    }

    var heightOfRowAt: CGFloat {
        return UITableView.automaticDimension
    }
    
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
 
        let row = posts[indexPath.section]
        
        if indexPath.row == 0 { // content
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostContentTableViewCell.reuseIdentifier, for: indexPath) as? PostContentTableViewCell else { return UITableViewCell() }

            
            
            cell.configureCell(username: row.user.username, content: row.text, date: row.createdAt)
            
            return cell
        } else { // comment
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCommentTableViewCell.reuseIdentifier, for: indexPath) as? PostCommentTableViewCell else { return UITableViewCell() }
            
            let commentTitle = row.comments.count == 0 ? "댓글쓰기" : "댓글 \(row.comments.count)"
            cell.configureCell(commentTitle: commentTitle)
            
            return cell
        }
    }
    
    func viewForFooterInSection(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView().getViewForFooterInSection(width: tableView.frame.size.width, height: 10, color: .lightGray)
        return view
    }
    
    func heightForFooterInSection(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}

