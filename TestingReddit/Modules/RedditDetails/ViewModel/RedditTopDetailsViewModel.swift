//
//  RedditTopDetailsViewModel.swift
//  TestingReddit
//
//  Created by Wilder López on 5/16/23.
//

import Foundation
import UIKit


protocol RedditTopDetailsViewModelProtocol {
    func didRequestPostDetails(post: Post)
}

class RedditTopDetailsViewModel {
    
    var delegate: RedditTopDetailsViewModelProtocol?
    
    //Use only for testing purposes
    var post: Post?
    
    init(delegate: RedditTopDetailsViewModelProtocol) {
        self.delegate = delegate
    }
    
    func requestPostDetails() {
        //Request fully post details
        
        //Use only for testing purposes
        guard let post else { return }
        delegate?.didRequestPostDetails(post: post)
    }
    
    
    
}
