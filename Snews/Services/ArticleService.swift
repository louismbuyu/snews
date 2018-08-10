//
//  ArticleService.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 06.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

import Alamofire

class ArticleService {
    static let instance = ArticleService()
    
    func getArticles(completion: @escaping (_ success: Bool,_ error: Error? ,_ message: String?,_ articles: [Article]?) -> ()) {
        Alamofire.request(URL_GET_ARTICLES, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                if let json = response.result.value as? Dictionary<String,Any> {
                    if let success = json["success"] as? Bool {
                        if success {
                            var newArticles = [Article]()
                            print("----")
                            if let articles = json["articles"] as? [Dictionary<String,Any>] {
                                print("----")
                                for article in articles {
                                    print("----")
                                    let newArticle = Article()
                                    if let temp = article["_id"] as? String {
                                        newArticle.id = temp
                                    }
                                    
                                    if let temp = article["title"] as? String {
                                        newArticle.title = temp
                                    }
                                    
                                    if let temp = article["url"] as? String {
                                        newArticle.url = temp
                                    }
                                    
                                    if let temp = article["subtitle"] as? String {
                                        newArticle.subTitle = temp
                                    }
                                    
                                    if let temp = article["provider"] as? String {
                                        let company = Company()
                                        company.id = temp
                                        company.name = temp
                                        newArticle.company = company
                                    }
                                    
                                    if let temp = article["imageUrl"] as? String {
                                        newArticle.imageUrl = temp
                                    }
                                    
                                    if let temp = article["timeStamp"] as? String {
                                        let timeStamp = customDates().mongodbStringToDate(date: temp).0
                                        newArticle.timeStamp = timeStamp
                                    }else {
                                        if let temp = article["createdAt"] as? String {
                                            let timeStamp = customDates().mongodbStringToDate(date: temp).0
                                            newArticle.timeStamp = timeStamp
                                        }
                                    }
                                    newArticles.append(newArticle)
                                }
                                completion(true,nil,json["msg"] as? String,newArticles)
                            }else{
                                completion(false,nil,json["msg"] as? String,nil)
                            }
                            
                        }else{
                            completion(false,nil,json["msg"] as? String,nil)
                        }
                    }else{
                        completion(false,nil,json["msg"] as? String,nil)
                    }
                }else{
                    completion(false,nil,"An error has occured, please try again later!",nil)
                }
            } else {
                completion(false, response.result.error!, "some message",nil)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func articleActionAdd(userId: String,articleId:String,type:Int,completion: @escaping (_ success: Bool,_ error: Error? ,_ message: String?) -> ()){
        let body: [String: Any] = [
            "userId": userId,
            "articleId": articleId,
            "type": type
        ]
        
        Alamofire.request("http://localhost:3000/article/v0/articlesAction/add", method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                if let json = response.result.value as? Dictionary<String,Any> {
                    if let success = json["success"] as? Bool {
                        if success {
                            completion(true,nil,json["msg"] as? String)
                        }else{
                            completion(false,nil,json["msg"] as? String)
                        }
                    }else{
                        completion(false,nil,json["msg"] as? String)
                    }
                }else{
                    completion(false,nil,"An error has occured, please try again later!")
                }
            } else {
                completion(false, response.result.error!, "some message")
                debugPrint(response.result.error as Any)
            }
        }
    }
}
