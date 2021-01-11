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
    
    static func getDefaultAlertController(title: String?, msg: String?) -> UIAlertController {
        let alert = UIAlertController(title: title!, message: msg!, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        return alert
    }
    
    static let themeColor = UIColor(red: 0.96, green: 0.96, blue: 0.86, alpha: 1.00)
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
