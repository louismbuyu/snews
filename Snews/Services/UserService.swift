//
//  UserService.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 06.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class UserService {
    static let instance = UserService()
    
    func updateProfile(userId: String, displayName: String,newImage: Bool, image: UIImage?, completion: @escaping (_ success: Bool,_ error: Error? ,_ message: String?) -> ()) {
        
        let body: [String: Any] = [
            "userId": userId,
            "displayName": displayName,
            "newImage": newImage
        ]
        
        Alamofire.request(URL_USER_UPDATE, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                if let json = response.result.value as? Dictionary<String,Any> {
                    if let success = json["success"] as? Bool {
                        if success {
                            if let postUrl = json["postUrl"] as? String {
                                self.performUpload(image: image!, postURL: postUrl, completionHandler: { (uploadSuccess) in
                                    if uploadSuccess {
                                        if let userObj = json["user"] as? Dictionary<String,Any> {
                                            
                                            AuthService.instance.userObject = userObj
                                            if let displayName = userObj["displayName"] as? String {
                                                AuthService.instance.userDisplayName = displayName
                                            }
                                            
                                            if let url = userObj["imageUrl"] as? String {
                                                let tempUrl = URL(string: url)
                                                let data = try? Data(contentsOf: tempUrl!)
                                                AuthService.instance.userImageData = data!
                                            }
                                        }
                                        completion(true,nil,"Success")
                                    }else{
                                        completion(false,nil,json["msg"] as? String)
                                    }
                                })
                            }else{
                                if let userObj = json["user"] as? Dictionary<String,Any> {
                                    AuthService.instance.userObject = userObj
                                    if let displayName = userObj["displayName"] as? String {
                                        AuthService.instance.userDisplayName = displayName
                                    }
                                }
                                completion(true,nil,"Success")
                            }
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
}
