//
//  Utils.swift
//  DMovie
//
//  Created by 김건영 on 2021/01/06.
//

import UIKit

class Utils {
    static func getFont(size: Int) -> UIFont {
        return UIFont.systemFont(ofSize: CGFloat(size))
    }
}

class LightBarStyleNavi: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class DarkBarStyleNavi: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
