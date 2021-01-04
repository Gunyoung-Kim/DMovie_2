//
//  UserInfoManager.swift
//  DMovie
//
//  Created by 김건영 on 2021/01/03.
//

import UIKit
import Alamofire

struct UserInfoKey {
    static let loginId = "LOGINID"
    static let name = "NAME"
    static let profile = "PROFILE"
}

class UserInfoManager {
    static let shared = UserInfoManager()
    
    private init() { }
    
    var loginId: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.loginId)
        }
        set(v) {
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.loginId)
            ud.synchronize()
        }
    }
    
    var name: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.name)
        }
        set(v) {
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.name)
            ud.synchronize()
        }
    }
    
    var profile: UIImage? {
        get {
            let ud = UserDefaults.standard
            if let _profile = ud.data(forKey: UserInfoKey.profile) {
                return UIImage(data: _profile)
            } else {
                return UIImage(named: "account.jpg")
            }
        }
        
        set(v) {
            if v != nil {
                let ud = UserDefaults.standard
                ud.set(v!.pngData(), forKey: UserInfoKey.profile)
                ud.synchronize()
            }
        }
    }
    
    var isLogin: Bool {
        if self.loginId == nil {
            return false
        } else {
            return true
        }
    }
    
    func login(id: String, passwd: String, success: (()->Void)? = nil, fail: ((String)->Void)? = nil) {
        let urlString = "http://\(HttpManager.SERVER_DOMAIN):\(HttpManager.SERVER_PORT)/login"
        let param: Parameters = [
            "id" : id,
            "password" : passwd
        ]
        
        let call = AF.request(urlString, method: .post, parameters: param, encoding: JSONEncoding.default)
        
        call.responseJSON { res in
            let result = try! res.result.get()
            
            guard let jsonObject = result as? NSDictionary else {
                fail?("잘못된 응답형식입니다:\(result)")
                return
            }
            
            let resultCode = jsonObject["result_code"] as! Int
            
            if resultCode == 0 {
                let user = jsonObject["user_info"] as! NSDictionary
                self.loginId = user["id"] as? String
                self.name = user["name"] as? String
                
                /*
                if let path = user["profile_path"] as? String {
                    if let imageData = try? Data(contentsOf: URL(string: path)!) {
                        self.profile = UIImage(data: imageData)
                    }
                }
                */
                success?()
                
            } else {
                let msg = (jsonObject["error_msg"] as? String) ?? "로그인에 실패했습니다."
                fail?(msg)
                
            }
        }
    }
    
    func logout(success: (() -> Void)? = nil, fail: ((String)->Void)? = nil) {
        let urlString = "http://\(HttpManager.SERVER_DOMAIN):\(HttpManager.SERVER_PORT)/logout"
        let param : Parameters = [
            "id" : self.loginId ?? ""
        ]
        
        let call = AF.request(urlString, method: .post, parameters: param, encoding: JSONEncoding.default)
        
        call.responseJSON { res in
            let result = try! res.result.get()
            
            guard let jsonObject = result as? NSDictionary else {
                fail?("잘못된 응답형식입니다")
                return
            }
            
            let resultCode = jsonObject["result_code"] as! Int
            
            if resultCode == 0 {
                self.deviceLogout()
                
                success?()
                
            } else {
                fail?(jsonObject["error_msg"] as? String ?? "로그아웃에 실패했습니다.")
                
            }
        }
    }
    
    func deviceLogout() {
        let ud = UserDefaults.standard
        
        ud.removeObject(forKey: UserInfoKey.loginId)
        ud.removeObject(forKey: UserInfoKey.name)
        ud.removeObject(forKey: UserInfoKey.profile)
        ud.synchronize()
    }
}

