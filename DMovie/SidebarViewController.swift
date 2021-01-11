//
//  SidebarViewController.swift
//  DMovie
//
//  Created by 김건영 on 2021/01/04.
//

import UIKit

class SidebarViewController: UITableViewController {
    let uinfo = UserInfoManager.shared
    
    let titles = [
        "Reservation",
        "Setting",
        "Version",
        "My Account"
    ]
    
    let nameLabel = UILabel()
    let IDLabel = UILabel()
    let profileImage = UIImageView()
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "sidecell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        cell.textLabel?.text = titles[indexPath.row]
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        cell.textLabel?.textColor = Utils.themeColor
        cell.backgroundColor = .black
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.titles[indexPath.row] == "My Account" {
            let uv = self.storyboard?.instantiateViewController(identifier: "Account_View_Navi")
            uv?.modalPresentationStyle = .fullScreen
            self.present(uv!, animated: true) {
                self.revealViewController()?.revealToggle(self)
            }
        } else if self.titles[indexPath.row] == "Setting" {
            let uv = self.storyboard?.instantiateViewController(identifier: "Setting_View_Navi")
            uv?.modalPresentationStyle = .fullScreen
            self.present(uv!, animated: true) {
                self.revealViewController()?.revealToggle(self)
            }
        } else if self.titles[indexPath.row] == "Version" {
            let alert = UIAlertController(title: "버전 정보", message: "ver 0.0.0", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            
            self.present(alert, animated: false)
        }
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .black
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        
        headerView.backgroundColor = Utils.themeColor
        
        self.tableView.tableHeaderView = headerView
        
        self.nameLabel.text = self.uinfo.name ?? "로그인이 필요합니다"
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.nameLabel.frame.size = CGSize(width: 200, height: 20)
        self.nameLabel.frame.origin = CGPoint(x: 70, y: 15)
        self.nameLabel.textColor = .black
        self.nameLabel.backgroundColor = .clear
        
        headerView.addSubview(nameLabel)
        
        self.IDLabel.text = self.uinfo.loginId
        self.IDLabel.textColor = .black
        self.IDLabel.backgroundColor = .clear
        self.IDLabel.frame.size = CGSize(width: self.view.frame.width - 80, height: 15)
        self.IDLabel.frame.origin = CGPoint(x: 70, y: 40)
        self.IDLabel.font = UIFont.boldSystemFont(ofSize: 11)
        
        headerView.addSubview(IDLabel)
        
        self.profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        self.profileImage.image = self.uinfo.profile
        self.profileImage.layer.borderWidth = 0
        self.profileImage.layer.masksToBounds = true
        
        headerView.addSubview(self.profileImage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.IDLabel.text = self.uinfo.loginId
        self.nameLabel.text = self.uinfo.name ?? "로그인이 필요합니다"
        self.profileImage.image = self.uinfo.profile
    }
}
