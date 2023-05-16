//
//  ViewController.swift
//  TestingReddit
//
//  Created by Wilder López on 5/15/23.
//

import UIKit

class RedditTopListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: RedditTopListViewModel?
    
    let refreshControl = UIRefreshControl()
    
    //list of post
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: PostTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: PostTableViewCell.identifier)
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        viewModel = .init(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.requestNextRedditTopList()
    }

    
    @objc func refreshList(_ sender: UIRefreshControl) {
        posts.removeAll()
        viewModel?.refreshRedditTopList()
    }
    
    //MARK: Navigation Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailsVC = segue.destination as? RedditTopDetailsViewController {
            detailsVC.viewModel = .init(delegate: detailsVC)
            detailsVC.viewModel?.post = sender as? Post
        }
    }

}

extension RedditTopListViewController : RedditTopListViewModelProtocol {
    func didResponseTopList(posts: [Post], isRefreshed: Bool = false) {
        if isRefreshed {
            self.posts.removeAll()
            refreshControl.endRefreshing()
        }
        self.posts.append(contentsOf: posts)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


