
import UIKit

import SnapKit

class PostWriteEditView: UIView, ViewPresentable {
    
    let textView = UITextView()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        
        self.backgroundColor = .white
        
        addSubview(textView)
        textView.font = .systemFont(ofSize: 18, weight: .semibold)
        textView.autocapitalizationType = .none
        

    }
    
    func setupConstraints() {
   
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
