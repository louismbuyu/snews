//
//  SearchUsersTVC.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 07.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class SearchUsersTVC: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate,UISearchResultsUpdating {
    
    var searchController: UISearchController!
    var article: Article?
    var userId: String?
    
    //var countries:[University] = []
    var users:[User] = []
    
    var searchDepartureCurrentCountry = String()
    
    deinit{
        if let superView = searchController.view.superview
        {
            superView.removeFromSuperview()
        }
    }
    var progressHUB = ProgressHUD(text: NSLocalizedString("Sending...", comment: "--"))
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = AuthService.instance.userId
        self.navigationItem.title = NSLocalizedString("Users", comment: "--")
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        
        self.searchController.searchBar.frame = CGRect(x: self.searchController.searchBar.frame.origin.x, y: self.searchController.searchBar.frame.origin.y, width: self.searchController.searchBar.frame.size.width, height: 44.0)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchBar.delegate = self
        
        self.tableView.tableFooterView = UIView()
        self.definesPresentationContext = true
        tableView.register(SearchUsersCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchUsersCell
        
        if let urlString = users[indexPath.row].imageUrl {
            let url = URL(string: urlString)
            cell.profileImage.af_setImage(withURL: url!)
        }
        cell.mainLbl.text = users[indexPath.row].displayName
        cell.subLbl.text = users[indexPath.row].username
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
    
    @objc func followAction(sender: UIButton){
        print(sender.tag)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        users.removeAll(keepingCapacity: false)
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            let body : [String: Any] = ["text": searchText.lowercased()]
            FullTextSearchService.instance.searchForUsers(body: body) { (success, error, msg, users) in
                if success {
                    if let users = users {
                        self.users = users
                    }
                    DispatchQueue.main.async {
                        //Run UI Updates or call completion block
                        //self.progressHUB.removeFromSuperview()
                        self.tableView.reloadData()
                    }
                }else{
                    print(error?.localizedDescription)
                }
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //let filtered = universities.filter { ($0.name?.contains(searchController.searchBar.text!))! }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tempUser = self.users[indexPath.row]
        shareMessage(receiverId: tempUser.id)
    }
    
    
    func shareMessage(receiverId: String){
        self.view.addSubview(progressHUB)
        let nextVC = CustomAlert()
        nextVC.modalPresentationStyle = .overFullScreen
        nextVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        MessageService.instance.shareArticle(senderId: userId!, receiverId: receiverId, articleId: (article?.id)!) { (success, error, message) in
            self.progressHUB.removeFromSuperview()
            if success {
                nextVC.actionCallback = { (view) in
                    view.dismiss(animated: true, completion: nil)
                    self.navigationController?.popViewController(animated: true)
                }
                nextVC.dialogTitle = NSLocalizedString("Success", comment: "--")
                nextVC.dialogMessage = NSLocalizedString("You have successfully shared this article!", comment: "--")
                nextVC.dialogImage = UIImage(named: "success")
            }else{
                nextVC.actionCallback = { (view) in
                    view.dismiss(animated: true, completion: nil)
                }
                nextVC.dialogTitle = NSLocalizedString("Oops", comment: "--")
                nextVC.dialogMessage = NSLocalizedString("Looks like an error has occured, please try again later.", comment: "--")
                nextVC.dialogImage = UIImage(named: "error")
            }
            self.present(nextVC, animated: true, completion: nil)
        }
    }
    
}
