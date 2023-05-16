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
    var posts: [Post] = []{
        didSet {
            title = "Reddit Top \(posts.count)"
        }
    }
    
    private var isLandscape = false
    
    //MARK: Cyclelife
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: PostTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: PostTableViewCell.identifier)
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        let saveAllButton = UIBarButtonItem(title: "Save All", style: .plain, target: self, action: #selector(saveAllButtonTapped))
        navigationItem.rightBarButtonItem = saveAllButton
        
        
        viewModel = .init(delegate: self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        viewModel?.requestServiceRedditTopList()
        viewModel?.loadLocalPost()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        let animationHandler: ((UIViewControllerTransitionCoordinatorContext) -> Void) = { [weak self] (context) in
            self?.tableView.reloadData()
        }

        let completionHandler: ((UIViewControllerTransitionCoordinatorContext) -> Void) = { [weak self] (context) in
            self?.tableView.reloadData()
        }

        coordinator.animate(alongsideTransition: animationHandler, completion: completionHandler)

    }
    
    //MARK: Methods
    
    @objc func refreshList(_ sender: UIRefreshControl) {
        viewModel?.refreshRedditTopList()
    }
    
    @objc func saveAllButtonTapped() {
        guard posts.count > 0 else { return }
        viewModel?.saveToCoreData(post: posts)
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
    func didResponseLocal(posts: [Post]) {
        if posts.isEmpty {
            viewModel?.requestServiceRedditTopList()
        }else {
            self.posts.removeAll()
            self.posts.append(contentsOf: posts)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
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
    
    func saveData(success: Bool) {
        if success {
            let alert = UIAlertController(title: "Saved", message: "Posts saved successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
        }else {
            let alert = UIAlertController(title: "Error", message: "Unable to save data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
        }
    }
}


