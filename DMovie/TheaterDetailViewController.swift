//
//  TheaterDetailViewController.swift
//  DMovie
//
//  Created by 김건영 on 2021/01/07.
//

import UIKit
import WebKit

class TheaterDetailViewController: UIViewController {
    var theater: TheaterVO!
    
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        let linkString = theater.link
        
        if linkString! == "" {
            self.present(Utils.getDefaultAlertController(title: "오류", msg: "해당 극장 홈페이지가 존재하지 않습니다."), animated: false, completion: nil)
        } else {
            let detailurl = URL(string: linkString!)
                
            let detailReq = URLRequest(url: detailurl!)
            self.webView.load(detailReq)
        }
    }
}
