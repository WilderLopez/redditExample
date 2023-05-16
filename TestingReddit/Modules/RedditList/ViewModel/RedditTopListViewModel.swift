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
}

class RedditTopListViewModel {
    private var currentPage = 0
    var delegate: RedditTopListViewModelProtocol?
    
    init(delegate: RedditTopListViewModelProtocol) {
        self.delegate = delegate
    }
    
    ///Restart the first page 0
    func refreshRedditTopList() {
        currentPage = 0
        loadRedditTopList(needRefresh: true)
    }
    
    
    func requestNextRedditTopList() {
        loadRedditTopList(page: currentPage)
        currentPage += 1
    }
    
    private func loadRedditTopList(page: Int = 0, needRefresh: Bool = false) {
        debugPrint("request page \(page)")
        NetworkManager.shared.getTopPosts(for: "", page: page, limit: 50) { [weak self] result in
            switch result {
            case .success(let posts):
                self?.delegate?.didResponseTopList(posts: posts, isRefreshed: needRefresh)
                
            case .failure(let error):
                
                print("Error: \(error)")
            }
        }
    }
    
    
    
    
    
    
    
}
