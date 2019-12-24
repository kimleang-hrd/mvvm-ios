//
//  ArticleTableViewController.swift
//  MVVMHomework
//
//  Created by Kimleang Kea on 12/23/19.
//  Copyright © 2019 Kimleang Kea. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {
    
    let loadMore = UIActivityIndicatorView(style: .medium)
    let refreshArticleControl = UIRefreshControl()
    
    let articleViewModel = ArticleViewModel()
    var articles = [ArticleModel]()
    
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadMore.startAnimating()
        fetchArticles()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ArticleTableViewCell", owner: self, options: [:])?.first! as! ArticleTableViewCell

        cell.setupCell(articles[indexPath.row])

        return cell
    }
    
    func setupTableView() {
        self.tableView.tableFooterView = loadMore
        self.tableView.allowsSelectionDuringEditing = false
        self.tableView.refreshControl = refreshArticleControl
        setupRefreshControl()
    }
    
    func setupRefreshControl() {
        self.refreshArticleControl.addTarget(self, action: #selector(refreshArticleTableView), for: .valueChanged)
    }
    
    @objc func refreshArticleTableView() {
        self.articles = []
        self.tableView.reloadData()
        self.page = 1
        print(articles)
        self.fetchArticles()
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.articles.count - 1 {
            page += 1
            fetchArticles()
            loadMore.startAnimating()
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .destructive, title: "Edit") { (_, _, _) in
            print("Edit")
        }
        edit.backgroundColor = .systemGreen
        edit.image = UIImage(systemName: "pencil")
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            print("Delete")
        }
        delete.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func fetchArticles() {
        articleViewModel.fetchArticles(page: page) { [weak self] (articles) in
            guard let self = self else {
                print("Self is error")
                return
            }
            self.articles += articles
            self.tableView.reloadData()
            self.loadMore.stopAnimating()
            self.refreshArticleControl.endRefreshing()
        }
    }
}
