//
//  RedditListViewController+TableView.swift
//  TestingReddit
//
//  Created by Wilder López on 5/16/23.
//

import Foundation
import UIKit

extension RedditTopListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        let row = indexPath.row
        cell.titleLable.text = posts[row].title
        let timeDescription = TimeHelper.timeAgoSinceDate(timeInterval: posts[row].created)
        cell.postedLabel.text = "- Posted by \(posts[row].author) \(timeDescription)"
        cell.subredditLabel.text = posts[row].subredditNamePrefixed
        cell.numComments.text = "\(posts[row].numComments) comments"
        
        //load thumbnails
        cell.loadThumbnailImage(url: posts[row].thumbnailUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        
        if indexPath.section == 0 && indexPath.row == lastRowIndex {
            
            viewModel?.requestNextRedditTopList()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        performSegue(withIdentifier: "RedditTopDetails", sender: post)
    }
    
}
