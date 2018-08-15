//
//  ArticlesTVC.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 04.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ArticlesTVC: UITableViewController,ShareActionProtocol {
    
    var articles = [Article]()
    var favorites = [String]()
    var likes = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ArticlesCell.self, forCellReuseIdentifier: "ArticlesCell")
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 180.0
        self.navigationItem.title = "News"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false
        
    }
    override func viewDidAppear(_ animated: Bool) {
        getArticles()
    }
    
    func getArticles(){
        ArticleService.instance.getArticles { (success, error, message, articles) in
            if success {
                if let articles = articles {
                    self.articles = articles
                }
                self.tableView.reloadData()
            }else{
                print("Error")
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesCell", for: indexPath) as? ArticlesCell
        
        let article = articles[indexPath.row]
        cell?.shareButton.tag = indexPath.row
        cell?.shareActionProtocol = self
        
        cell?.mediaCompanyImageView.image = UIImage(named: article.company.name)
        cell?.mediaCompanyNameLbl.text = article.company.name
        
        cell?.dateLbl.text = customDates().recentDate(article.timeStamp)
        cell?.titleLbl.text = article.title
        cell?.subTitleLbl.text = article.subTitle
        
        if let imageUrl = article.imageUrl {
            let url = URL(string: imageUrl)
            cell?.articleImageView.af_setImage(withURL: url!)
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nextVC = ArticleWebViewVC()
        nextVC.article = self.articles[indexPath.row]
        nextVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func shareAction(articlesCell: ArticlesCell) {
        
        let nextVC = SearchUsersTVC()
        nextVC.article = self.articles[articlesCell.shareButton.tag]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    /*func likeAction(artcilesCell: ArticlesCell) {
        if artcilesCell.liked! {
            print("true")
            artcilesCell.likeButton.setImage(UIImage(named: "unfilledheart"), for: .normal)
            artcilesCell.likeButton.tintColor = UIColor.gray
            artcilesCell.liked = false
        }else{
            print("false")
            artcilesCell.likeButton.setImage(UIImage(named: "filledheart"), for: .normal)
            artcilesCell.likeButton.tintColor = UIColor.red
            artcilesCell.liked = true
        }
        print("Selected \(artcilesCell.likeButton.tag)")
    }*/
    
    
    /*func favoriteAction(artcilesCell: ArticlesCell) {
        if artcilesCell.favorited! {
            print("true")
            artcilesCell.favoriteButton.setImage(UIImage(named: "unfilledstar"), for: .normal)
            artcilesCell.favoriteButton.tintColor = UIColor.gray
            artcilesCell.favorited = false
        }else{
            print("false")
            artcilesCell.favoriteButton.setImage(UIImage(named: "filledstar"), for: .normal)
            artcilesCell.favoriteButton.tintColor = UIColor.yellow
            artcilesCell.favorited = true
        }
        print("Selected \(artcilesCell.favoriteButton.tag)")
    }*/
}
