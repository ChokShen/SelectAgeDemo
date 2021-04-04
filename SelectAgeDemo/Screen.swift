//
//  Screen.swift
//  SelectAgeDemo
//
//  Created by Chok Shen on 2021/4/4.
//

import UIKit

struct Screen {
    static let Width = UIScreen.main.bounds.size.width
    static let Height = UIScreen.main.bounds.size.height
    static var isIPhoneX: Bool {
        if #available(iOS 11, *) {
              guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
                  return false
              }
              
              if unwrapedWindow.safeAreaInsets.bottom > 0 {
                  return true
              }
        }
        return false
    }
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    static let navigationBarHeight: CGFloat = 44
    static let navigationHeight = statusBarHeight + navigationBarHeight
    static let topSafeHeight: CGFloat = isIPhoneX ? 48 : 0
    static let bottomSafeHeight: CGFloat = isIPhoneX ? 34 : 0
}
