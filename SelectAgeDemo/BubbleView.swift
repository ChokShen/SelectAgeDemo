//
//  BubbleView.swift
//  SelectAgeDemo
//
//  Created by Chok Shen on 2021/4/3.
//

import UIKit

class BubbleView: UIView {
    
    var number: String? {
        didSet {
            titleLabel.text = number
        }
    }
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "bubble")
        return imageView
    }()
    override var frame: CGRect {
        didSet {
            layout()
        }
    }

    // MARK: - init
    convenience init(origin: CGPoint) {
        self.init(frame: CGRect(origin: origin, size: CGSize.zero))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - layout
    private func initUI() {
        self.addSubview(imageView)
        self.addSubview(titleLabel)
    }
    
    private func layout() {
        imageView.frame = self.bounds
        let titleLabelH: CGFloat = 44
        titleLabel.frame = CGRect(x: 0, y: (imageView.bounds.height - titleLabelH) / 2 - 12, width: imageView.bounds.width, height: titleLabelH)
    }

}
