//
//  MovieVO.swift
//  DMovie
//
//  Created by 김건영 on 2020/12/28.
//

import UIKit

class MovieVO {
    var rankInten: String?      // 전일대비 순위 증감분
    var rankOldAndNew: String?      // 랭킹 신규 진입여부 OLD:기존, NEW:신규
    
    var movieNm: String?        // 영화 이름(국문)
    
    var link: String?       //영화의 하이퍼텍스트 link
    var imageUrl: String? = "default"    //영화 썸네일 url
}
