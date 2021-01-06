//
//  MainViewController.swift
//  DMovie
//
//  Created by 김건영 on 2020/12/27.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    var categories = ["오늘의 영화", "주간 베스트 영화"]
    
    override func viewDidLoad() {
        getBoxOffice()
        
        if let revealVC = self.revealViewController() {
            let btn = UIBarButtonItem()
            btn.image = UIImage(named: "sidemenu.png")
            btn.target = revealVC
            btn.action = #selector(revealVC.revealToggle(_:))
            btn.tintColor = UIColor(red: 0.96, green: 0.96, blue: 0.86, alpha: 1.00)
            
            self.navigationItem.leftBarButtonItem = btn
            
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
        
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    func getBoxOffice() {
        let urlString = "http://\(HttpManager.SERVER_DOMAIN):\(HttpManager.SERVER_PORT)/rank" //자취방 IP
       
        let url = URL(string: urlString)!
        
        let apiData = try! Data(contentsOf: url)
        
        do {
            let object = try JSONSerialization.jsonObject(with: apiData, options: []) as? NSDictionary
            
            guard let jsonObject = object!["boxofficeResult"] as? NSDictionary else {
                return
            }
            
            let daily = jsonObject["dailyMovies"] as! NSArray
            
            for movie in daily {
                let m = movie as! NSDictionary
                let mvo = MovieVO()
                
                mvo.movieNm = m["title"] as? String
                mvo.rankInten = String(m["rankInten"] as! Int)
                if m["rankOldAndNew"] as! Int == 0 {
                    mvo.rankOldAndNew = "false"
                } else {
                    mvo.rankOldAndNew = "true"
                }
                mvo.link = m["link"] as? String
                mvo.imageUrl = m["thumbnailLink"] as? String
            
                BoxOffice.shared.dailyRankList.append(mvo)
            }
            
            let weekly = jsonObject["weeklyMovies"] as! NSArray
            
            for movie in weekly {
                let m = movie as! NSDictionary
                let mvo = MovieVO()
                
                mvo.movieNm = m["title"] as? String
                mvo.rankInten = String(m["rankInten"] as! Int)
                if m["rankOldAndNew"] as! Int == 0 {
                    mvo.rankOldAndNew = "false"
                } else {
                    mvo.rankOldAndNew = "true"
                }
                mvo.link = m["link"] as? String
                mvo.imageUrl = m["thumbnailLink"] as? String
            
                BoxOffice.shared.weeklyRankList.append(mvo)
            }
        } catch {
            NSLog("parse Error!")
        }
        
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            var cell: UITableViewCell
            cell = tableView.dequeueReusableCell(withIdentifier: "mainCell")!
            cell.backgroundColor = .black
            return cell
        } else if indexPath.section == 1{
            var cell: DailyRow
            cell = tableView.dequeueReusableCell(withIdentifier: "dailyCell") as! DailyRow
            cell.viewcontroller = self
            cell.backgroundColor = .black
            return cell
        } else {
            var cell: WeeklyRow
            cell = tableView.dequeueReusableCell(withIdentifier: "weeklyCell") as! WeeklyRow
            cell.viewcontroller = self
            cell.backgroundColor = .black
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count + 1
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let v = UIView()
            v.frame.origin = CGPoint(x: 0, y: 0)
            v.frame.size = CGSize(width: self.view.frame.width , height: 10)
            v.backgroundColor = .black
            
            return v
        } else {
            let v = UIView()
            let textHeader = UILabel()
            
            textHeader.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 2.0))
            textHeader.textColor = UIColor(red: 0.96, green: 0.96, blue: 0.86, alpha: 1.00)
            
            v.frame.origin = CGPoint(x: 0, y: 0)
            
            textHeader.text = categories[section-1]
            textHeader.sizeToFit()
            textHeader.frame.origin = CGPoint(x: 20 , y: 15)
            v.frame.size = CGSize(width: self.view.frame.width , height: 10)
            v.backgroundColor = .black
            
            v.addSubview(textHeader)
            return v;
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return CGFloat(300)
        } else {
            return HttpManager().loadThumbnailImage(BoxOffice.shared.dailyRankList[0].imageUrl!).size.height + DailyRow().hardCodedPadding * 5
        }
    }
 
}

