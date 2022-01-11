
import UIKit

class PostViewModel {
    
    var posts: [Post] = []
    var post: Post?
    
    var comments: [CommentDetail] = []
    var comment: CommentDetail?
    
    var writeEditText: Observable<String> = Observable("")
    
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
        APIService.postContent(token: token, text: writeEditText.value) { data, error in
            if let data = data {
                print("POST post 성공!")
//                dump(data)
//                self.posts = [data] // 저장할 필요 없을듯
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
        APIService.putContent(token: token, text: writeEditText.value, postId: postId) { data, error in
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
    
    func getUserComment(completion: @escaping (APIError?) -> Void) {
        guard let postId = post?.id else { return }
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.getComment(token: token, postId: postId) { data, error in
            if let data = data {
                print("GET comment 성공!")
                dump(data)
                self.comments = data
                completion(nil)
            } else {
                print("GET post 실패!")
                dump(error)
                completion(error)
            }
        }
    }
    
    func postUserComment(completion: @escaping (APIError?) -> Void) {
        guard let postId = post?.id else { return }
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        print("text.value = \(writeEditText.value)")
        APIService.postComment(token: token, comment: writeEditText.value, postId: postId) { data, error in
            if let data = data {
                print("GET comment 성공!")
                dump(data)
                self.comment = data
                completion(nil)
            } else {
                print("GET post 실패!")
                dump(error)
                completion(error)
            }
        }
    }
    
    func putUserComment(completion: @escaping (APIError?) -> Void) {
        guard let postId = post?.id else { return }
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.putComment(token: token, comment: writeEditText.value, postId: postId) { data, error in
            if let data = data {
                print("PUT comment 성공!")
//                dump(data)
                self.comment = data
                completion(nil)
            } else {
                print("PUT post 실패!")
                dump(error)
                completion(error)
            }
        }
    }
    
    func deleteUserComment(completion: @escaping (APIError?) -> Void) {
        guard let postId = post?.id else { return }
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        APIService.deleteComment(token: token, postId: postId) { data, error in
            if let data = data {
                print("DELETE comment 성공!")
//                dump(data)
                self.comment = data
                completion(nil)
            } else {
                print("DELETE post 실패!")
                dump(error)
                completion(error)
            }
        }
    }
}

extension PostViewModel: UITableViewCellRepresentable {
    
    
    
    var numberOfSection: Int {
        return posts.count
    }
    
    var numberOfRowsInSection: Int {
        return 2 // content cell + comment cell
    }

    var heightOfRowAt: CGFloat {
        return UITableView.automaticDimension
    }
    
    func postCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
 
        let row = posts[indexPath.section]
        
        if indexPath.row == 0 { // content cell
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostContentTableViewCell.reuseIdentifier, for: indexPath) as? PostContentTableViewCell else { return UITableViewCell() }

            
            
            cell.configureCell(username: row.user.username, content: row.text, date: row.updatedAt)
            
            return cell
        } else { // comment cell
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCommentTableViewCell.reuseIdentifier, for: indexPath) as? PostCommentTableViewCell else { return UITableViewCell() }
            
            let commentTitle = row.comments.count == 0 ? "댓글쓰기" : "댓글 \(row.comments.count)"
            cell.configureCell(commentTitle: commentTitle)
            
            return cell
        }
        
        
        func commentCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailCommentTableViewCell.reuseIdentifier, for: indexPath) as? PostDetailCommentTableViewCell else { return UITableViewCell() }
            
            if comments.count > 0 {
                let row = comments[indexPath.row]
                let username = row.user.username
                let content = row.comment
                cell.configureCell(username: username, content: content)
            }
            
            return cell
        }
        
        
    }
    
    
    
//    func viewForFooterInSection(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//
//        let view = UIView().getViewForFooterInSection(width: tableView.frame.size.width, height: 10, color: .systemGray3)
//        return view
//    }
    
//    func heightForFooterInSection(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 10
//    }
    
    
}

