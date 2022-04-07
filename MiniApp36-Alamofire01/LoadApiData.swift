//
//  LoadApiData.swift
//  MiniApp36-Alamofire01
//
//  Created by 前田航汰 on 2022/04/06.
//

import Foundation
import Alamofire

protocol LoadApiDataDelegate: AnyObject {
    func presentInfo(infos: [Article.Detail])
}

class LoadApiData {

    weak var delegate: LoadApiDataDelegate?

    func load(category: String) {

        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=jp&pageSize=25&category=\(category)&apiKey=cf9d0892883f46fd88c3c1740496cbfc")!

        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {
            response in
            switch response.result{
            case .success:
                do{
                    let articles = [try JSONDecoder().decode(Article.self, from: response.data!).articles]
                    DispatchQueue.main.async {
                        self.delegate?.presentInfo(infos: articles[0])
                    }
                }
                catch{
                    print("取得失敗")
                }
            case .failure(_):
                print("失敗")
            }
        }
    }
}
