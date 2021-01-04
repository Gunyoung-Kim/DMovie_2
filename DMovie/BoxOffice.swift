//
//  BoxOffice.swift
//  DMovie
//
//  Created by 김건영 on 2021/01/01.
//

import Foundation

class BoxOffice {
    static let shared = BoxOffice()
    private init() {}
    
    lazy var dailyRankList: [MovieVO] = [MovieVO]()
    lazy var weeklyRankList: [MovieVO] = [MovieVO]()
}
