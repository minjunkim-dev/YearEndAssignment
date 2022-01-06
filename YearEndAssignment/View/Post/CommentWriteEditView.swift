
import UIKit

import SnapKit

class CommentWriteEditView: UIView, ViewPresentable {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    let textView = UITextView()
    
    func setupView() {
        
        self.backgroundColor = .white
        
        addSubview(textView)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 2
        textView.layer.cornerRadius = 10
        textView.autocapitalizationType = .none
        textView.font = .systemFont(ofSize: 18, weight: .semibold)
        textView.sizeToFit()
        textView.isScrollEnabled = false
    }
    
    func setupConstraints() {
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
//            make.height.equalTo(textView.snp.width).multipliedBy(0.33)
        }
    }
}

