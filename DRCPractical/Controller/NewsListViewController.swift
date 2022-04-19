//
//  NewsListViewController.swift
//  DRCPractical
//
//  Created by nikunj sareriya on 19/04/22.
//

import UIKit

class NewsListViewController: UIViewController {

    @IBOutlet weak var tblNewsList: UITableView! {
        didSet {
            self.tblNewsList.delegate = self
            self.tblNewsList.dataSource = self
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            self.activityIndicator.startAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Common.networkAvailability() {
            DataModel.sharedInstance.deleteNewsList()
            ApiManager.callNewsListAPI { (isSuccess) in
                if isSuccess {
                    for news in newsModel {
                        DataModel.sharedInstance.setNewsData(newsData: news)
                    }
                    self.tblNewsList.reloadData()
                    self.activityIndicator.isHidden = true
                }
            }
        } else {
            self.getDataAndSetDatainTableView()
            self.activityIndicator.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    func getDataAndSetDatainTableView() {
        newsModel.removeAll()
        if let newsList = DataModel.sharedInstance.getNewsList() as? [NewsDetails] {
            for datam in newsList {
                newsModel.append(NewsListModel(source_name: datam.source_name!, author_name: datam.author_name!, desc: datam.desc!, title: datam.title!, urlMain: datam.urlMain!, urlImage: datam.urlImage!, dateTime: datam.datetime!, urlData: datam.urlToImage!))
            }
            self.tblNewsList.reloadData()
        }
    }


}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.lblTitle.text = newsModel[indexPath.row].title
        cell.lblSourceName.text = newsModel[indexPath.row].author_name
        cell.lblDTAuthorName.text = newsModel[indexPath.row].dateTime + " " + newsModel[indexPath.row].source_name
        cell.imgNews.image = UIImage(data: newsModel[indexPath.row].urlData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsDeatilViewController") as? NewsDeatilViewController {
            vC.model = newsModel[indexPath.row]
            self.navigationController?.pushViewController(vC, animated: true)
        }
    }
    
}

