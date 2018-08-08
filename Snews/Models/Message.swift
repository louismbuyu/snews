//
//  Chat.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 04.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class Message {
    var id: String!
    var article: Article?
    var message: String!
    var chatRoomId: String!
    var senderUser: User!
    var receiverUser: User!
    var timeStamp: Date!
    var read: Bool!
}
