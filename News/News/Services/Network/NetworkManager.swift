//
//  NetworkManager.swift
//  News
//
//  Created by Mahmud CIKRIK on 17.02.2024.
//

import Foundation
import Alamofire

let service = NewsService.shared

enum APIError: Error {
    case failedToDecodeData
    case failedToRequest(error: Error)
}

protocol NewsServiceProtocol: AnyObject {
    func fetchSource(completion: @escaping (Result<[Source], Error>) -> Void)
    func fetchTopHeadlines (sourceName: String, completion: @escaping (Result<[Article], Error>) -> Void)
}

struct Constants {
    static let API_KEY = "&apiKey=70f1b465b49e4887b7475352d68461e0"
    static let baseURL = "https://newsapi.org/"
}

struct Paths {
    static let sources = "v2/top-headlines/sources?"
    static let headlines = "v2/top-headlines?"
}

struct Querys {
    static let language = "language=en"
    static let newsSources = "sources="
}

class NewsService: NewsServiceProtocol {
    
    static let shared = NewsService()
    
    private init () { }
    
    public func fetchSource(completion: @escaping (Result<[Source], Error>) -> Void) {
        
        let urlString = "\(Constants.baseURL + Paths.sources + Querys.language + Constants.API_KEY)"
        print(urlString)
        AF.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let allNewsData = try decoder.decode(SourcesModel.self, from: data)
                        
                        completion(.success(allNewsData.sources))
                        
                    } catch let error {
                        print("Error decoding data: \(error)")
                        completion(.failure(error))
                    }
            case .failure(let error):
                print("Request failed with error: \(error)")
                
            }
            
        }
        
    }
    
    public func fetchTopHeadlines (sourceName: String, completion: @escaping (Result<[Article], Error>) -> Void) {
     
        let urlString = "\(Constants.baseURL + Paths.headlines + Querys.newsSources + sourceName + Constants.API_KEY)"
        
        AF.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                    do {
                        let decoder = Decoders.plainDateDecoder
                        let newsData = try decoder.decode(TopHeadlinesModel.self, from: data)
                        completion(.success(newsData.articles))
                        
                    } catch let error {
                        print("Error decoding data: \(error)")
                        completion(.failure(error))
                    }
            case .failure(let error):
                print("Request failed with error: \(error)")
                
            }
            
        }
        
    }
    

}
