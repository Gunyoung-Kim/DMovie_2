//
//  MainViewController.swift
//  DMovie
//
//  Created by 김건영 on 2020/12/27.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    var categories = ["극장 상영 영화", "오늘의 영화", "주간 베스트 영화"]
    let image = UIImage(named: "toy_story.jpg")
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        getBoxOffice()
        self.navigationController?.isNavigationBarHidden = true
        
        /*
        let rightBtn = UIBarButtonItem()
        rightBtn.image = UIImage(systemName: "bell")
        rightBtn.tintColor = Utils.themeColor
        
        self.navigationItem.rightBarButtonItem = rightBtn
         */
        
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
            
            let screening = jsonObject["screeningMovies"] as! NSArray
            
            for movie in screening {
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
            
                BoxOffice.shared.screeningList.append(mvo)
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
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: (self.image?.size.height)!))
            imageView.image = image
            imageView.isUserInteractionEnabled = true
            cell.backgroundColor = .black
            cell.addSubview(imageView)
            
            if let revealVC = self.revealViewController() {
                let btn = UIButton()
                btn.setImage(UIImage(named: "sidemenu.png"), for: .normal)
                btn.frame = CGRect(x: imageView.frame.size.width / 40, y: imageView.frame.size.height / 35, width: 30, height: 30)
                btn.addTarget(revealVC, action: #selector(revealVC.revealToggle(_:)), for: .touchUpInside)
                btn.setImage(btn.currentImage?.withTintColor(Utils.themeColor), for: .normal)
                
                imageView.addSubview(btn)
                
                self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
            }
            
            return cell
        } else if indexPath.section == 1 {
            var cell: ScreeningRow
            cell = tableView.dequeueReusableCell(withIdentifier: "screeningCell") as! ScreeningRow
            cell.viewcontroller = self
            cell.backgroundColor = .black
            return cell
        } else if indexPath.section == 2 {
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
            v.frame.size = CGSize(width: self.view.frame.width , height: 0)
            v.backgroundColor = .white
            
            return v
        } else {
            let v = UIView()
            let textHeader = UILabel()
            
            textHeader.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 2.0))
            textHeader.textColor = Utils.themeColor
            
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 25
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return (self.image?.size.height)!
        } else if indexPath.section == 1 {
            return HttpManager().loadThumbnailImage(BoxOffice.shared.screeningList[0].imageUrl!).size.height + ScreeningRow().hardCodedPadding * 5
        } else {
            return HttpManager().loadThumbnailImage(BoxOffice.shared.dailyRankList[0].imageUrl!).size.height + DailyRow().hardCodedPadding * 5
        }
    }
 
}

