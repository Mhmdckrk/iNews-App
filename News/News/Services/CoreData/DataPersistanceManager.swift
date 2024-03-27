//
//  DataPersistanceManager.swift
//  News
//
//  Created by Mahmud CIKRIK on 26.02.2024.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistenceManager()
 
    func saveNews (model: NewsDetailModel, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let item = SavedNewsItems(context: context)
        item.id = model.id
        item.content = model.content
        item.imgUrl = model.imgUrl
        item.pageTitle = model.pageTitle
        item.title = model.title
        item.date = model.date
        item.formattedDate = model.formattedDate
        item.savedAt = model.savedDate
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
        
    }
    
    func fetchingNewsFromDataBase(completion: @escaping (Result<[SavedNewsItems], Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<SavedNewsItems>
        
        request = SavedNewsItems.fetchRequest()
    
        do {
            let news = try context.fetch(request)
            completion(.success(news))
            
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteTitleWith(model: SavedNewsItems, completion: @escaping (Result<Void, Error>)-> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
        
    }
    
}
