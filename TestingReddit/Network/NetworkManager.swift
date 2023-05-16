//
//  NetworkManager.swift
//  TestingReddit
//
//  Created by Wilder López on 5/15/23.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    let baseUrl = "https://www.reddit.com/"
    
    func getTopPosts(for query: String, page: Int, limit: Int, completion: @escaping (Result<[Post], Error>) -> Void) {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = URL(string: "\(baseUrl)\(trimmedQuery.count == 0 ? "" : "r/\(trimmedQuery)")/top.json?limit=\(limit)&page=\(page)") else {
            preconditionFailure("Failed to construct search URL for query: \(query)")
        }
        
        AF.request(url)
        .responseDecodable(of: Listing.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.posts))
                break
                
            case .failure(let error):
                debugPrint("error \(error)")
                break;
            }
        }
    }
}
