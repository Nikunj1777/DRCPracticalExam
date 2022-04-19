//
//  NewsDeatilViewController.swift
//  DRCPractical
//
//  Created by nikunj sareriya on 19/04/22.
//

import UIKit

class NewsDeatilViewController: UIViewController {

    @IBOutlet weak var tblNewsDetail: UITableView! {
        didSet {
            self.tblNewsDetail.delegate = self
            self.tblNewsDetail.dataSource = self
        }
    }
    var model: NewsListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapWebLink(_ sender: UIButton) {
        if Common.networkAvailability() {
            if let vC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoadNewsViewController") as? LoadNewsViewController {
                vC.webLink = URL(string: model?.urlMain ?? "")
                self.navigationController?.pushViewController(vC, animated: true)
            }
        } else {
            Common.showAlert(title: "You're offline", message: "Please turn on your internet")
        }
    }
    
    @objc func didTapImgForZomming(_ sender: UITapGestureRecognizer) {
        if Common.networkAvailability() {
            if let vC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoadNewsViewController") as? LoadNewsViewController {
                vC.webLink = URL(string: model?.urlImage ?? "")
                self.navigationController?.pushViewController(vC, animated: true)
            }
        } else {
            Common.showAlert(title: "You're offline", message: "Please turn on your internet")
        }
    }

}

extension NewsDeatilViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailsTableViewCell", for: indexPath) as? NewsDetailsTableViewCell else {
            return UITableViewCell()
        }
        if let model = model {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapImgForZomming(_:)))
            cell.imgNews.addGestureRecognizer(tap)
            cell.imgNews.image = UIImage(data: model.urlData)
            cell.imgNews.isUserInteractionEnabled = true
            cell.lblTitle.text = model.title
            cell.lblDesc.text = model.desc
            cell.lblSourceName.text = model.source_name
            cell.lblDateTime.text = model.dateTime
            cell.lblAuthorName.text = model.author_name
            cell.btnWebLink.setTitle(model.urlMain, for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
}
