//
//  ViewController.swift
//  SelectAgeDemo
//
//  Created by Chok Shen on 2021/4/3.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var backBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 20, y: Screen.statusBarHeight, width: 44, height: 44)
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.contentHorizontalAlignment = .left
        return btn
    }()
    private lazy var progressBar: ProgressBarView = {
        let progressBarX = backBtn.frame.maxX + 16
        let progressBar = ProgressBarView(frame: CGRect(x: progressBarX, y: Screen.statusBarHeight, width: view.bounds.width - progressBarX, height: 44))
        return progressBar
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: backBtn.frame.origin.x, y: backBtn.frame.maxY + 32, width: 200, height: 44))
        label.text = "How old are you?"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private lazy var ageScaleView: AgeScaleView = {
        let ageScaleView = AgeScaleView(frame: CGRect(x: 0, y: titleLabel.frame.maxY + 100, width: view.bounds.width, height: 192))
        ageScaleView.delegate = self
        ageScaleView.defalutAge = 34
        return ageScaleView
    }()
    private var age: Int = 0
    private lazy var continueBtn: UIButton = {
        let btn = UIButton(type: .custom)
        let btnH: CGFloat = 44
        btn.frame = CGRect(x: 48, y: view.bounds.height - Screen.bottomSafeHeight - 12 - btnH , width: view.bounds.width - 48 * 2, height: btnH)
        btn.setTitle("Continue", for: .normal)
        btn.backgroundColor = UIColor.tintBlue
        btn.layer.cornerRadius = 22
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
        return btn
    }()

    // MARK: - life
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        initUI()
        // Do any additional setup after loading the view.
    }
    
    func initUI() {
        view.addSubview(backBtn)
        view.addSubview(progressBar)
        view.addSubview(titleLabel)
        view.addSubview(ageScaleView)
        view.addSubview(continueBtn)
    }
    
    // MARK: - action
    @objc private func continueAction() {
        print("Your age is \(age)")
    }
}

// MARK: - AgeScaleViewDelegate
extension ViewController: AgeScaleViewDelegate {
    func ageDidChanged(_ age: Int) {
        self.age = age
    }
}

