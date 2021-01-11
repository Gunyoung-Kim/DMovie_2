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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = mvo.movieNm!
        let detailurl = URL(string: mvo.link!)
            
        let detailReq = URLRequest(url: detailurl!)
        self.webView.load(detailReq)
    }
    
}
