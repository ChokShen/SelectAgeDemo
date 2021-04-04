//
//  AgeScaleView.swift
//  SelectAgeDemo
//
//  Created by Chok Shen on 2021/4/3.
//

import UIKit

protocol AgeScaleViewDelegate: class {
    func ageDidChanged(_ age: Int)
}

class AgeScaleView: UIView {
    
    var defalutAge: Int = 34 {
        didSet {
            scrollTo(age: defalutAge)
        }
    }
    var minAge: Int = 1
    var maxAge: Int = 108
    weak var delegate: AgeScaleViewDelegate?
    private lazy var bubbleView: BubbleView = {
        let view = BubbleView()
        return view
    }()
    private lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    private var isScrollRight: Bool = true
    private lazy var markView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tintBlue
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var baselineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.secondaryGray
        return view
    }()
    private lazy var scaleViews: [UIView] = {
        return [UIView]()
    }()
    private lazy var markScaleLabels: [UILabel] = {
        return [UILabel]()
    }()
    private var leftEdgeOfMinScale: CGFloat {
        return self.bounds.width / 2
    }
    private var rightEdgeOfMaxScale: CGFloat {
        return self.bounds.width / 2
    }
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
        self.addSubview(bubbleView)
        self.addSubview(scrollView)
        self.addSubview(markView)
        scrollView.addSubview(baselineView)
        for i in minAge ... maxAge {
            let view = UIView()
            view.backgroundColor = UIColor.secondaryGray
            view.tag = i
            if isMarkSacle(i) {
                let label = UILabel()
                label.text = "\(i)"
                label.font = UIFont.boldSystemFont(ofSize: 14)
                label.textColor = UIColor.black
                label.textAlignment = .center
                scrollView.addSubview(label)
                markScaleLabels.append(label)
            }
            scrollView.addSubview(view)
            scaleViews.append(view)
        }
    }
    
    private func layout() {
        let bubbleViewW: CGFloat = 120
        let bubbleViewH: CGFloat = 132
        bubbleView.frame = CGRect(x: (self.bounds.width - bubbleViewW) / 2, y: 0, width: bubbleViewW, height: bubbleViewH)
        scrollView.frame = CGRect(x: 0, y: bubbleView.frame.maxY + 12, width: self.bounds.width, height: 48)
        let markViewW: CGFloat = 4
        markView.frame = CGRect(x: (self.bounds.width - markViewW) / 2, y: scrollView.frame.origin.y, width: markViewW, height: scrollView.bounds.height)
        let scaleGap: CGFloat = 12
        let scaleWidth: CGFloat = 2
        var markCount: Int = 0
        let count = scaleViews.count
        for i in 0 ..< count {
            let scaleView = scaleViews[i]
            let tag = scaleView.tag
            if isMarkSacle(tag) {
                scaleView.frame = CGRect(x: leftEdgeOfMinScale + CGFloat(i) * (scaleGap + scaleWidth), y: 12, width: scaleWidth, height: 12)
                let markScaleLabelW: CGFloat = 64
                let markScaleLabelX = scaleView.frame.origin.x - (markScaleLabelW - scaleWidth) / 2
                    markScaleLabels[markCount].frame = CGRect(x: markScaleLabelX, y: scaleView.frame.maxY + 8, width: markScaleLabelW, height: 18)
                markCount += 1
            } else {
                scaleView.frame = CGRect(x: leftEdgeOfMinScale + CGFloat(i) * (scaleGap + scaleWidth), y: 12, width: scaleWidth, height: 8)
            }
        }
        let lastScaleView = scaleViews.last
        baselineView.frame = CGRect(x: 0, y: 24, width: (lastScaleView?.frame.maxX ?? self.bounds.width) + rightEdgeOfMaxScale, height: 2)
        scrollView.contentSize = CGSize(width: baselineView.bounds.width, height: 0)
    }
    
    private func isMarkSacle(_ scale: Int) -> Bool {
        let str = "\(scale)"
        if str == "1" || str.hasSuffix("8") {
            return true
        } else {
            return false
        }
    }

}

// MARK: - UIScrollViewDelegate
extension AgeScaleView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let translatedPoint = scrollView.panGestureRecognizer.translation(in: scrollView)
        isScrollRight = translatedPoint.x < 0 ? true : false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !scrollView.isDragging {
            calculateCurrentScale()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        calculateCurrentScale()
    }
        
    private func calculateCurrentScale() {
        if isScrollRight {
            for scaleView in scaleViews {
                let x = scaleView.frame.origin.x - scrollView.contentOffset.x
                if x == markView.frame.origin.x {
                    bubbleView.number = "\(scaleView.tag)"
                    delegate?.ageDidChanged(scaleView.tag)
                    break
                } else {
                    if x > markView.frame.origin.x {
                        let distance = x - markView.frame.origin.x
                        scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x + distance, y: 0), animated: true)
                        bubbleView.number = "\(scaleView.tag)"
                        delegate?.ageDidChanged(scaleView.tag)
                        break
                    }
                }
            }
        } else {
            for scaleView in scaleViews.reversed() {
                let x = scaleView.frame.origin.x - scrollView.contentOffset.x
                if x == markView.frame.origin.x {
                    bubbleView.number = "\(scaleView.tag)"
                    delegate?.ageDidChanged(scaleView.tag)
                    break
                } else {
                    if x < markView.frame.origin.x {
                        let distance = markView.frame.origin.x - x
                        scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x - distance, y: 0), animated: true)
                        bubbleView.number = "\(scaleView.tag)"
                        delegate?.ageDidChanged(scaleView.tag)
                        break
                    } else {
                        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                        bubbleView.number = "\(scaleView.tag)"
                        delegate?.ageDidChanged(scaleView.tag)
                    }
                }
            }
        }
    }
    
    private func scrollTo(age: Int) {
        bubbleView.number = "\(age)"
        for scaleView in scaleViews {
            if scaleView.tag == age {
                scrollView.setContentOffset(CGPoint(x: scaleView.frame.origin.x - markView.frame.origin.x, y: 0), animated: false)
                break
            }
        }
    }
}
