//
//  RedditTopListViewModel.swift
//  TestingReddit
//
//  Created by Wilder López on 5/16/23.
//

import Foundation
import UIKit

protocol RedditTopListViewModelProtocol : AnyObject {
    func didResponseTopList(posts: [Post], isRefreshed: Bool)
    
    func saveData(success: Bool)
    func didResponseLocal(posts: [Post])
}

class RedditTopListViewModel {
    var delegate: RedditTopListViewModelProtocol?
    private var uniquePost : [Post] = []
    
    init(delegate: RedditTopListViewModelProtocol) {
        self.delegate = delegate
    }
    
    func saveToCoreData(post: [Post]) {
        CoreDataManager.shared.saveAllPosts(post) { [weak self] response in
            self?.delegate?.saveData(success: response)
        }
    }
    
    func loadLocalPost() {
        let posts : [Post] = CoreDataManager.shared.fetchAllPosts()
        delegate?.didResponseLocal(posts: posts)
    }
    
    ///Restart the first page 0
    func refreshRedditTopList() {
        loadRedditTopList(needRefresh: true)
    }
    
    
    func requestServiceRedditTopList(after: String = "") {
        loadRedditTopList(after: after)
    }
    
    private func loadRedditTopList(after: String = "", needRefresh: Bool = false) {

        NetworkManager.shared.getTopPosts(for: "all",after: after, limit: 10) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let posts):
//                let existingPostIDs = self.uniquePost.map({ $0.id })
//                let newPosts = posts.filter { !existingPostIDs.contains($0.id) }
//                    
//                self.uniquePost.append(contentsOf: newPosts)
                self.delegate?.didResponseTopList(posts: posts, isRefreshed: needRefresh)
                
            case .failure(let error):
                
                print("Error: \(error)")
            }
        }
    }
    
    
    
    
    
    
    
    
    
}
