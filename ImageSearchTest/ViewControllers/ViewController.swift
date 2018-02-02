//
//  ViewController.swift
//  ImageSearchTest
//
//  Created by Oleksii Shulzhenko on 01.02.2018.
//  Copyright © 2018 Oleksii Shulzhenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {
    
    let searchBar = UISearchBar()
    let tableView = UITableView.init(frame: CGRect.zero)
    let dataSource = ImageTableViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.view.backgroundColor = .white
        
        configureSubviews()
        configureTableView()
        
        searchBar.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard))
        
        tableView.addGestureRecognizer(tap)
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width / 375 * 174 + 24
    }
    
    //MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text! != "" {
        ImageModelController.share.retriveImage(for: searchBar.text!) { [weak self](success, errorMessage) in
            if !success {
                self?.showError("Error", message: errorMessage!, okDidPressed: nil)
            } else {
                DispatchQueue.main.async {
                    self?.tableView.beginUpdates()
                    self?.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                    self?.tableView.endUpdates()
                }
            }
            }
        }
        searchBar.endEditing(true)
    }
    
    
    //MARK: - METHODS
    
    @objc func hideKeyboard() {
        self.searchBar.endEditing(true)
    }
    
    func configureSubviews() {
        self.view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        tableView.backgroundColor = .white
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureTableView() {
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.Identifier)
        tableView.dataSource = self.dataSource
        tableView.delegate = self
    }
}


