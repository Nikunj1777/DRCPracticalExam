//
//  NewsListModel.swift
//  DRCPractical
//
//  Created by nikunj sareriya on 19/04/22.
//

import Foundation

class NewsListModel {
    var source_name: String!
    var author_name: String!
    var desc: String!
    var title: String!
    var urlMain: String!
    var urlData: Data!
    var urlImage: String!
    var dateTime: String!
    
    init (source_name: String, author_name: String, desc: String, title: String, urlMain: String, urlImage: String, dateTime: String, urlData: Data) {
        self.source_name = source_name
        self.author_name = author_name
        self.desc = desc
        self.title = title
        self.urlMain = urlMain
        self.urlImage = urlImage
        self.dateTime = dateTime
        self.urlData = urlData
    }
}
