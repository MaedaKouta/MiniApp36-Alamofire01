//
//  ViewController.swift
//  MiniApp36-Alamofire01
//
//  Created by 前田航汰 on 2022/04/06.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    enum Category: String {
        case technology = "technology"
        case business = "business"
        case health = "health"
        case sports = "sports"
    }

    @IBOutlet private weak var categorySegmentedContorol: UISegmentedControl!
    private var articles: [Article.Detail] = []
    @IBOutlet private weak var tableView: UITableView!
    private let loadApiData = LoadApiData()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadApiData.delegate = self
        loadSetApiData(index: categorySegmentedContorol.selectedSegmentIndex)
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.estimatedRowHeight = 150 //追加
        tableView.rowHeight = UITableView.automaticDimension //追加
    }

    @IBAction private func didTapLookButton(_ sender: Any) {
        loadSetApiData(index: categorySegmentedContorol.selectedSegmentIndex)
    }

    private func loadSetApiData(index: Int) {
        switch index {
        case 0:
            loadApiData.load(category: Category.business.rawValue)
        case 1:
            loadApiData.load(category: Category.technology.rawValue)
        case 2:
            loadApiData.load(category: Category.health.rawValue)
        default:
            loadApiData.load(category: Category.sports.rawValue)
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        cell.titleLabel.text = articles[indexPath.row].title ?? "タイトルなし"
        cell.detailLabel.text = articles[indexPath.row].description ?? "詳細なし"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

}

extension ViewController: LoadApiDataDelegate {
    func presentInfo(infos: [Article.Detail]) {
        articles = infos

        // tableViewを更新したらヘッダーに戻るコード
        tableView.setContentOffset(.zero, animated: false)
        tableView.layoutIfNeeded()
        tableView.reloadData()
    }

}
