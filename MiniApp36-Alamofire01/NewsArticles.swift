//
//  NewsArticles.swift
//  MiniApp36-Alamofire01
//
//  Created by 前田航汰 on 2022/04/07.
//

import Foundation

struct Article: Codable {
    let articles: [Detail]

    struct Detail: Codable {
        let description: String?
        let title: String?
    }
}
