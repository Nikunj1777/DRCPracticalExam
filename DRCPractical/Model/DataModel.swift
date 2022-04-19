//
//  DataModel.swift
//  DRCPractical
//
//  Created by nikunj sareriya on 19/04/22.
//

import Foundation
import CoreData
import UIKit

class DataModel: NSObject {
    static let sharedInstance = DataModel()
    // MARK: - Save data in coredata
    func saveContext() {
        DispatchQueue.main.async {
            appDelegate.saveContext()
        }
    }
    
    // MARK: - Get data from coredata
    func getNewsList() -> [NewsDetails] {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsDetails")
        request.returnsObjectsAsFaults = false
        do {
            if let result = try context.fetch(request) as? [NewsDetails] {
                return result
            }
            return []
        } catch {
        }
        return []
    }
    
    // MARK: - Set data in coredata
    func setNewsData(newsData: NewsListModel) {
        let context = appDelegate.persistentContainer.viewContext
        guard let news = NSEntityDescription.insertNewObject(forEntityName: "NewsDetails", into: context) as? NewsDetails else { return }
        news.setValue(newsData.author_name, forKey: "author_name")
        news.setValue(newsData.source_name, forKey: "source_name")
        news.setValue(newsData.desc, forKey: "desc")
        news.setValue(newsData.title, forKey: "title")
        news.setValue(newsData.urlMain, forKey: "urlMain")
        news.setValue(newsData.urlImage, forKey: "urlToImage")
        news.setValue(newsData.dateTime, forKey: "datetime")
        self.saveContext()
    }
    
    // MARK: - Delete data in coredata
    func deleteNewsList() -> Bool {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"NewsDetails")
        do {
            if let fetchedResults =  try managedContext.fetch(fetchRequest) as? [NSManagedObject] {
                for entity in fetchedResults {
                    managedContext.delete(entity)
                }
                self.saveContext()
                return true
            }
            return false
        } catch {
            print("Could not delete")

        }
        return false
    }
}


