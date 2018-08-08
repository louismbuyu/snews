//
//  Parsers.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 07.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class Parsers {
    
    func convertDictionaryToArticle(article: Dictionary<String,Any>) -> Article {
        let newArticle = Article()
        if let temp = article["_id"] as? String {newArticle.id = temp}
        if let temp = article["title"] as? String {newArticle.title = temp}
        if let temp = article["url"] as? String {newArticle.url = temp}
        if let temp = article["subtitle"] as? String {newArticle.subTitle = temp}
        
        if let temp = article["provider"] as? String {
            let company = Company()
            company.id = temp
            company.name = temp
            newArticle.company = company
        }
        
        if let temp = article["imageUrl"] as? String {newArticle.imageUrl = temp}
        
        if let temp = article["createdAt"] as? String {
            let timeStamp = customDates().mongodbStringToDate(date: temp).0
            newArticle.timeStamp = timeStamp
        }
        return newArticle
    }
    
    func convertDictionaryToUser(user: Dictionary<String,Any>) -> User {
        let newUser = User()
        if let temp = user["_id"] as? String {newUser.id = temp}
        if let temp = user["displayName"] as? String {newUser.displayName = temp}
        if let temp = user["username"] as? String {newUser.username = temp}
        if let temp = user["imageUrl"] as? String {newUser.imageUrl = temp}
        return newUser
    }
    
    func convertDictionaryToMessage(jsonMessage: Dictionary<String,Any>) -> Message {
        let newMessage = Message()
        if let temp = jsonMessage["_id"] as? String {
            newMessage.id = temp
        }
        
        if let temp = jsonMessage["text"] as? String {
            newMessage.message = temp
        }
        
        if let temp = jsonMessage["chatRoomId"] as? String {
            newMessage.chatRoomId = temp
        }
        
        if let temp = jsonMessage["read"] as? Bool {
            newMessage.read = temp
        }
        
        if let temp = jsonMessage["created_at"] as? String {
            let timeStamp = customDates().mongodbStringToDate(date: temp).0
            newMessage.timeStamp = timeStamp
        }
        
        if let temp = jsonMessage["senderUser"] as? Dictionary<String,Any> {
            newMessage.senderUser = Parsers().convertDictionaryToUser(user: temp)
        }
        
        if let temp = jsonMessage["receiverUser"] as? Dictionary<String,Any> {
            newMessage.receiverUser = Parsers().convertDictionaryToUser(user: temp)
        }
        
        if let temp = jsonMessage["article"] as? Dictionary<String,Any> {
            newMessage.article = Parsers().convertDictionaryToArticle(article: temp)
        }
        return newMessage
    }
}
