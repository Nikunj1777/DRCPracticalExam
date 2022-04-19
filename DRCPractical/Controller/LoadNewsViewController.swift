//
//  LoadNewsViewController.swift
//  DRCPractical
//
//  Created by nikunj sareriya on 19/04/22.
//

import UIKit
import WebKit

class LoadNewsViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var webLink: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let urlDoc = self.webLink as? URL, let request = URLRequest(url: urlDoc) as? URLRequest {
            self.webView.load(request)
        } else {
            Common.showAlert(title: "Opps", message: "News is not found")
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
