//
//  ViewController.swift
//  DMovie
//
//  Created by 김건영 on 2020/12/27.
//

import UIKit
import NMapsMap

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
    }
}
