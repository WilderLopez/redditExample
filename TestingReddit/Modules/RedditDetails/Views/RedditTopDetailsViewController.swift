//
//  RedditTopDetailsViewController.swift
//  TestingReddit
//
//  Created by Wilder López on 5/16/23.
//

import Foundation
import UIKit
import SDWebImage

class RedditTopDetailsViewController: UIViewController {
    
    @IBOutlet weak var subredditLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fullImageView: UIImageView!
    
    //Injected Dependency
    var viewModel: RedditTopDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        viewModel = .init(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.requestPostDetails()
    }
    
    
}

extension RedditTopDetailsViewController: RedditTopDetailsViewModelProtocol {
    func didRequestPostDetails(post: Post) {
        subredditLabel.text = post.subredditNamePrefixed
        authorLabel.text = post.author
        
        let timeDescription = TimeHelper.timeAgoSinceDate(timeInterval: post.created)
        timeLabel.text = timeDescription
        
        titleLabel.text = post.title
        
        fullImageView.sd_setImage(with: post.fullImageUrl)
        fullImageView.sd_imageTransition = .fade(duration: 0.5)
        fullImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
    }
    
    
}


