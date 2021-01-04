//
//  Theaters.swift
//  DMovie
//
//  Created by 김건영 on 2021/01/02.
//

import Foundation

class Theaters {
    static let shared = Theaters()
    private init() {
        theaters = [TheaterVO]()
    }
    
    var theaters: [TheaterVO]
    
    func loadTheatersInfo(completion: (()->Void)? = nil) {
        let urlString = "http://\(HttpManager.SERVER_DOMAIN):\(HttpManager.SERVER_PORT)/theater"
        
        guard let url = URL(string: urlString) else {
            NSLog("theater API url is incorrect")
            return
        }
        
        let apiData = try! Data(contentsOf: url)
        
        do {
            let object = try JSONSerialization.jsonObject(with: apiData, options: []) as? NSDictionary
            
            guard let jsonObject = object!["theaterResult"] as? NSDictionary else {
                NSLog("Thearter Info Parse Error!(th theaterResult)")
                return
            }
            
            guard let theaters = jsonObject["theaters"] as? NSArray else {
                NSLog("Theater Info Parse Error!(to theaters)")
                return
            }
            
            for theater in theaters {
                
                let theaterJSON = theater as! NSDictionary
                let theaterVO = TheaterVO()
                
                theaterVO.name = theaterJSON["name"] as? String
                theaterVO.address = theaterJSON["address"] as? String
                theaterVO.lot_number = theaterJSON["lot_number"] as? String
                theaterVO.xpos = theaterJSON["xpos"] as? Double ?? -1
                theaterVO.ypos = theaterJSON["ypos"] as? Double ?? -1
                theaterVO.open = theaterJSON["open"] as? Bool
                theaterVO.link = theaterJSON["link"] as? String
                
                self.theaters.append(theaterVO)
            }
            
            completion?()
            
        } catch {
            NSLog("parse Error!")
        }
    }
}
