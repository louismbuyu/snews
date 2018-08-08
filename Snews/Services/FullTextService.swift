//
//  FullTextService.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 07.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

import Alamofire

class FullTextSearchService {
    
    static let instance = FullTextSearchService()
    
    func searchForUsers(body: [String: Any],completion: @escaping (_ success: Bool,_ error: Error?,_ message: String?,_ users: [User]?) -> ()){
        Alamofire.request(URL_USERS_SEARCH, method: .post, parameters: body, encoding: JSONEncoding.default, headers:HEADER).responseJSON { (response) in
            if response.result.error == nil {
                if let json = response.result.value as? Dictionary<String,Any> {
                    if let success = json["success"] as? Bool {
                        if success {
                            if let users = json["users"] as? [Dictionary<String,Any>] {
                                var newUsers = [User]()
                                for user in users {
                                    let newUser = User()
                                    if let temp = user["_id"] as? String {newUser.id = temp}
                                    if let temp = user["displayName"] as? String {newUser.displayName = temp}
                                    if let temp = user["username"] as? String {newUser.username = temp}
                                    if let temp = user["imageUrl"] as? String {newUser.imageUrl = temp}
                                    newUsers.append(newUser)
                                }
                                
                                completion(true, nil, nil ,newUsers)
                            }else{
                                completion(false, nil, "Error happened", nil)
                            }
                        }else{
                            completion(false, nil, json["message"] as? String, nil)
                        }
                    }
                }
            } else {
                completion(false, response.result.error!, "some message", nil)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
