//
//  SettingViewController.swift
//  DMovie
//
//  Created by 김건영 on 2021/01/04.
//

import UIKit

class SettingViewController: UITableViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBAction func alarmSet(_ sender: UISwitch) {
        var alert: UIAlertController?
        let todayDate: String = {
            let now = Date()

            let date = DateFormatter()
            date.locale = Locale(identifier: "ko_kr")
            date.timeZone = TimeZone(abbreviation: "KST")
            date.dateFormat = "yyyy-MM-dd HH:mm:ss"

            let kr = date.string(from: now)
            return kr
        }()
        
        if sender.isOn {
            let msg = "\(todayDate) \n 마케팅 푸쉬 알림 설정이 동의 되었습니다."
            alert = UIAlertController(title: "알림", message: msg, preferredStyle: .alert)
            
        } else {
            let msg = "\(todayDate) \n 마케팅 푸쉬 알림 설정이 해제되었습니다."
            alert = UIAlertController(title: "알림", message: msg, preferredStyle: .alert)
        }
        
        alert?.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        
        self.present(alert!, animated: false)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.tableView.tintColor = .clear
        
        let closeBtn = UIBarButtonItem()
        closeBtn.style = .plain
        closeBtn.target = self
        closeBtn.action = #selector(close(_ :))
        closeBtn.title = "닫기"
        
        self.navigationItem.leftBarButtonItem = closeBtn
        
        self.navigationController?.navigationBar.backgroundColor = .white
    }
    
    @objc func close(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
