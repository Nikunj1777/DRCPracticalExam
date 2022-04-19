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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiManager.callNewsListAPI { (isSuccess) in
            if isSuccess {
                
            }
        }
        // Do any additional setup after loading the view.
    }


}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

