//
//  AuthService.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 06.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AuthService {
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var loggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var userObject : Dictionary<String,Any> {
        get {
            return (defaults.value(forKey: USER_OBJECT_KEY) as? Dictionary<String,Any>)!
        }
        
        set {
            defaults.set(newValue, forKey: USER_OBJECT_KEY)
        }
    }
    
    var userImageData: Data {
        get {
            return (defaults.value(forKey: USER_IMAGE_DATA_KEY) as? Data)!
        }
        set {
            defaults.set(newValue, forKey: USER_IMAGE_DATA_KEY)
        }
    }
    
    var username: String {
        get {
            return defaults.value(forKey: USERANME_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: USERANME_KEY)
        }
    }
    
    var userDisplayName: String {
        get {
            return defaults.value(forKey: USER_DISPLAY_NAME_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_DISPLAY_NAME_KEY)
        }
    }
    
    var userId: String {
        get {
            return defaults.value(forKey: USER_ID_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_ID_KEY)
        }
    }
    
    func registerUser(username: String, password: String,image: UIImage, completion: @escaping (_ success: Bool,_ error: Error? ,_ message: String?) -> ()) {
        
        let lowerCaseUsername = username.lowercased()
        
        let body: [String: Any] = [
            "username": lowerCaseUsername,
            "password": password
        ]
        
        Alamofire.request(URL_USER_CREATE, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                
                if let json = response.result.value as? Dictionary<String,Any> {
                    if let success = json["success"] as? Bool {
                        if success {
                            let postUrl = json["postUrl"] as? String
                            self.performUpload(image: image, postURL: postUrl!, completionHandler: { (uploadSuccess) in
                                if uploadSuccess {
                                    if let userObj = json["user"] as? Dictionary<String,Any> {
                                        
                                        self.userObject = userObj
                                        if let id = userObj["_id"] as? String {
                                            self.userId = id
                                        }
                                        
                                        if let username = userObj["username"] as? String {
                                            self.username = username
                                        }
                                        
                                        if let displayName = userObj["displayName"] as? String {
                                            self.userDisplayName = displayName
                                        }
                                        
                                        if let url = userObj["imageUrl"] as? String {
                                            let tempUrl = URL(string: url)
                                            let data = try? Data(contentsOf: tempUrl!)
                                            self.userImageData = data!
                                        }
                                    }
                                    self.loggedIn = true
                                    completion(true,nil,"Success")
                                }else{
                                    completion(false,nil,json["msg"] as? String)
                                }
                            })
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
    
    func loginUser(username: String, password: String, completion: @escaping (_ success: Bool,_ error: Error? ,_ message: String?) -> ()) {
        
        let lowerCaseUsername = username.lowercased()
        
        let body: [String: Any] = [
            "username": lowerCaseUsername,
            "password": password
        ]
        
        Alamofire.request(URL_USER_SIGNIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                if let json = response.result.value as? Dictionary<String,Any> {
                    if let success = json["success"] as? Bool {
                        if success {
                            if let userObj = json["user"] as? Dictionary<String,Any> {
                                
                                self.userObject = userObj
                                if let id = userObj["_id"] as? String {
                                    self.userId = id
                                }
                                
                                if let username = userObj["username"] as? String {
                                    self.username = username
                                }
                                
                                if let displayName = userObj["displayName"] as? String {
                                    self.userDisplayName = displayName
                                }
                                
                                if let url = userObj["imageUrl"] as? String {
                                    let tempUrl = URL(string: url)
                                    let data = try? Data(contentsOf: tempUrl!)
                                    self.userImageData = data!
                                }
                            }
                            
                            self.loggedIn = true
                            completion(true, nil, nil)
                        }else{
                            completion(false, nil, json["msg"] as? String)
                        }
                    }else{
                        completion(false, nil, "An error has occured, please try again later!")
                    }
                }else{
                    completion(false, nil, "An error has occured, please try again later!")
                }
            } else {
                completion(false, response.result.error!, "Something")
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func performUpload(image: UIImage, postURL: String, completionHandler: @escaping (_ success:Bool) -> ()){
        if let imageData = UIImageJPEGRepresentation(image, 0.2) {
            let request = Alamofire.upload(imageData, to: postURL, method: .put, headers: ["Content-Type":"image/jpeg"])
            request.validate()
            request.response(completionHandler: { (response) in
                if response.error != nil {
                    DispatchQueue.main.async(execute: {() -> Void in
                        //Update progress
                        print(response.error)
                        completionHandler(false)
                    })
                }else{
                    DispatchQueue.main.async(execute: {() -> Void in
                        completionHandler(true)
                    })
                }
            })
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

