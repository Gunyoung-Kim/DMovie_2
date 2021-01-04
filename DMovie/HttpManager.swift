//
//  HttpManager.swift
//  DMovie
//
//  Created by 김건영 on 2020/12/28.
//

import UIKit

class HttpManager {
    
    static let SERVER_DOMAIN = "121.131.99.47"
    static let SERVER_PORT = "8888"
    
    func loadThumbnailImage(_ imageUrl: String) -> UIImage {
        if imageUrl == "" {
            return UIImage(named: "thumbnail.jpg")!
        }
        let url = URL(string: imageUrl)
        let imageData = try! Data(contentsOf: url!)
        
        guard let image = UIImage(data: imageData) else {
            return UIImage(named: "thumbnail.jpg")!
        }
        
        return image
    }
}
