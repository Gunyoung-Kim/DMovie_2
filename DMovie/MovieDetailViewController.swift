//
//  MovieDetailViewController.swift
//  DMovie
//
//  Created by 김건영 on 2021/01/04.
//

import UIKit
import WebKit

class MovieDetailViewController: UIViewController {
    var mvo: MovieVO!
    
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        let detailurl = URL(string: mvo.link!)
        
        let detailReq = URLRequest(url: detailurl!)
        
        self.webView.load(detailReq)
    }
    
}
