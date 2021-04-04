//
//  ProgressBarView.swift
//  SelectAgeDemo
//
//  Created by Chok Shen on 2021/4/3.
//

import UIKit

class ProgressBarView: UIView {
    
    var page: Int = 1 {
        didSet {
            updatePage()
        }
    }
    var totalPage = 8
    private var progress: CGFloat {
        return CGFloat(page) / CGFloat(totalPage)
    }
    private lazy var progressBar: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.tintBlue
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var progressBarBackgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "1/8"
        label.textAlignment = .center
        return label
    }()
    override var frame: CGRect {
        didSet {
            layout()
        }
    }
    
    // MARK: - init
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
        self.addSubview(progressBarBackgroundView)
        self.addSubview(progressBar)
        self.addSubview(titleLabel)
    }
    
    private func layout() {
        self.bounds.size = CGSize(width: self.bounds.width, height: 32)
        let titleLabelW: CGFloat = 48
        let titleLabelR: CGFloat = 8 //right edge
        let titleLabelH: CGFloat = 20
        titleLabel.frame = CGRect(x: self.bounds.width - titleLabelR - titleLabelW, y: (self.bounds.height - titleLabelH) / 2, width: titleLabelW, height: titleLabelH)
        let progressBarBackgroundViewR: CGFloat = 32 //right edge
        let progressBarBackgroundViewH: CGFloat = 8
        progressBarBackgroundView.frame = CGRect(x: 0, y: (self.bounds.height - progressBarBackgroundViewH) / 2, width: titleLabel.frame.origin.x - progressBarBackgroundViewR, height: progressBarBackgroundViewH)
        progressBar.frame = CGRect(x: 0, y: progressBarBackgroundView.frame.origin.y, width: progressBarBackgroundView.frame.width * progress, height: progressBarBackgroundView.frame.height)
    }
    
    // MARK: - page
    private func updatePage() {
        progressBar.bounds.size = CGSize(width: progressBarBackgroundView.bounds.width * progress, height: progressBar.bounds.height)
        titleLabel.text = "\(page)/\(totalPage)"
    }
}
