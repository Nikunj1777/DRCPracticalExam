//
//  APIManager.swift
//  DRCPractical
//
//  Created by nikunj sareriya on 19/04/22.
//

import Foundation
import Alamofire

let user_api = "https://newsapi.org/v2/top-headlines?sources=google-news&apiKey=6af81286ada84e78a1de589db7861af3"

class ApiManager: NSObject {
    
    // Asynchronous Method
    class func callRequest(_ url: String, withParameters parameters: [String: Any], header: [String: String], requestTimeOut duration: Int, success: @escaping (Any) -> Void, failure: @escaping (Error) -> Void) {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = TimeInterval(duration)
        AF.request(url, method: .get, parameters: parameters, headers: HTTPHeaders.init(header)).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let data):
                success(data as Any)
            case .failure(let error):
                failure(error as Error)
            }
        })
    }
    
    class func callNewsListAPI(completionHandler: @escaping (Bool) -> Void) {
        self.callRequest(user_api, withParameters: [:], header: [:], requestTimeOut: 60) { response in
            if let result = response as? [String: Any], let arrNews = result["articles"] as? [[String: Any]], let isStatus = result["status"] as? String, isStatus == "ok" {
                for result in arrNews {
                    if let author = result["author"] as? String, let title = result["title"] as? String, let desc = result["description"] as? String, let source = result["source"] as? [String: Any], let sourceName = source["name"] as? String, let urlmain = result["url"] as? String, let urlimg = result["urlToImage"] as? String, let date = result["publishedAt"] as? String, let data = Common.setDataImageFromString(imgString: urlimg) as? Data {
                        print(date)
                        if let datetime = Common.convertDateFormat(inputDate: date) as? String {
                            newsModel.append(NewsListModel(source_name: sourceName, author_name: author, desc: desc, title: title, urlMain: urlmain, urlImage: urlimg, dateTime: datetime, urlData: data))
                        }
                    }
                }
                    completionHandler(true)
            } else {
                completionHandler(false)
            }
        } failure: { error in
            print(error.localizedDescription)
            completionHandler(false)
        }

    }
}
