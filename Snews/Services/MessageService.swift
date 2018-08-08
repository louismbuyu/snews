//
//  MessageService.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 07.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

import Alamofire

class MessageService {
    static let instance = MessageService()
    
    func readMessage(messageId: String,completion: @escaping (_ success: Bool,_ error: Error? ,_ message: String?) -> ()) {
        
        let body: [String: Any] = [
            "messageId": messageId
        ]
        Alamofire.request(URL_MESSAGE_READ, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                if let json = response.result.value as? Dictionary<String,Any> {
                    if let success = json["success"] as? Bool {
                        if success {
                            completion(true,nil,nil)
                        }else{
                            completion(false,nil,json["message"] as? String)
                        }
                    }else{
                        completion(false,nil,json["message"] as? String)
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
    
    func shareArticle(senderId: String, receiverId: String, articleId: String,completion: @escaping (_ success: Bool,_ error: Error? ,_ message: String?) -> ()) {
        
        let body: [String: Any] = [
            "senderId": senderId,
            "receiverId": receiverId,
            "articleId": articleId
        ]
        Alamofire.request(URL_MESSAGE_CREATE, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                if let json = response.result.value as? Dictionary<String,Any> {
                    if let success = json["success"] as? Bool {
                        if success {
                            completion(true,nil,nil)
                        }else{
                            completion(false,nil,json["message"] as? String)
                        }
                    }else{
                        completion(false,nil,json["message"] as? String)
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
    
    func sendTextMessage(senderId: String, receiverId: String, text: String,completion: @escaping (_ success: Bool,_ error: Error? ,_ message: String?,_ newMessage:Message?) -> ()) {
        
        let body: [String: Any] = [
            "senderId": senderId,
            "receiverId": receiverId,
            "text": text
        ]
        Alamofire.request(URL_MESSAGE_CREATE, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                if let json = response.result.value as? Dictionary<String,Any> {
                    if let success = json["success"] as? Bool {
                        if success {
                            if let jsonMessage = json["savedMessage"] as? Dictionary<String,Any> {
                                
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
                                
                                completion(true,nil,nil,newMessage)
                            }
                        }else{
                            completion(false,nil,json["message"] as? String,nil)
                        }
                    }else{
                        completion(false,nil,json["message"] as? String,nil)
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
    
    func getRecentChats(userId: String,completion: @escaping (_ success: Bool,_ error: Error? ,_ message: String?,_ recentChats:[RecentChat]?) -> ()) {
        
        let body: [String: Any] = [
            "userId": userId
        ]
        Alamofire.request(URL_MESSAGE_RECENT_CHATS, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                if let json = response.result.value as? Dictionary<String,Any> {
                    if let success = json["success"] as? Bool {
                        if success {
                            
                            var newrRecentChats = [RecentChat]()
                            
                            if let recentChats = json["recentChats"] as? [Dictionary<String,Any>] {
                                
                                for recentChat in recentChats {
                                    
                                    let newRecentChat = RecentChat()
                                    if let temp = recentChat["_id"] as? String {
                                        newRecentChat.id = temp
                                    }
                                    
                                    if let temp = recentChat["text"] as? String {
                                        newRecentChat.text = temp
                                    }
                                    
                                    if let temp = recentChat["read"] as? Bool {
                                        newRecentChat.read = temp
                                    }
                                    
                                    if let temp = recentChat["article"] as? Dictionary<String,Any> {
                                        newRecentChat.article = Parsers().convertDictionaryToArticle(article: temp)
                                    }
                                    
                                    if let temp = recentChat["senderUser"] as? Dictionary<String,Any> {
                                        newRecentChat.senderUser = Parsers().convertDictionaryToUser(user: temp)
                                    }
                                    
                                    if let temp = recentChat["receiverUser"] as? Dictionary<String,Any> {
                                        newRecentChat.receiverUser = Parsers().convertDictionaryToUser(user: temp)
                                    }
                                    
                                    if let temp = recentChat["timestamp"] as? String {
                                        let timeStamp = customDates().mongodbStringToDate(date: temp).0
                                        newRecentChat.timeStamp = timeStamp
                                    }
                                    newrRecentChats.append(newRecentChat)
                                }
                                completion(true,nil,json["msg"] as? String,newrRecentChats)
                            }else{
                                completion(false,nil,json["msg"] as? String,nil)
                            }
                            
                        }else{
                            completion(false,nil,json["message"] as? String,nil)
                        }
                    }else{
                        completion(false,nil,json["message"] as? String,nil)
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
    
    func getChatRoomMessages(userId: String, chatRoomId: String,completion: @escaping (_ success: Bool,_ error: Error? ,_ message: String?,_ messages: [Message]?) -> ()) {
        
        let body: [String: Any] = [
            "userId": userId,
            "chatRoomId": chatRoomId
        ]
        Alamofire.request(URL_MESSAGE_CHATROOM, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                if let json = response.result.value as? Dictionary<String,Any> {
                    if let success = json["success"] as? Bool {
                        if success {
                            var newMessages = [Message]()
                            
                            if let messages = json["messages"] as? [Dictionary<String,Any>] {
                                
                                for message in messages {
                                    let newMessage = Message()
                                    if let temp = message["_id"] as? String {
                                        newMessage.id = temp
                                    }
                                    
                                    if let temp = message["text"] as? String {
                                        newMessage.message = temp
                                    }
                                    
                                    if let temp = message["chatRoomId"] as? String {
                                        newMessage.chatRoomId = temp
                                    }
                                    
                                    if let temp = message["read"] as? Bool {
                                        newMessage.read = temp
                                    }
                                    
                                    if let temp = message["created_at"] as? String {
                                        let timeStamp = customDates().mongodbStringToDate(date: temp).0
                                        newMessage.timeStamp = timeStamp
                                    }
                                    
                                    if let temp = message["senderUser"] as? Dictionary<String,Any> {
                                        newMessage.senderUser = Parsers().convertDictionaryToUser(user: temp)
                                    }
                                    
                                    if let temp = message["receiverUser"] as? Dictionary<String,Any> {
                                        newMessage.receiverUser = Parsers().convertDictionaryToUser(user: temp)
                                    }
                                    
                                    if let temp = message["article"] as? Dictionary<String,Any> {
                                        newMessage.article = Parsers().convertDictionaryToArticle(article: temp)
                                    }
                                    
                                    newMessages.append(newMessage)
                                }
                            }
                            completion(true,nil,json["message"] as? String,newMessages)
                        }else{
                            completion(false,nil,json["message"] as? String,nil)
                        }
                    }else{
                        completion(false,nil,json["message"] as? String,nil)
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
    
}
