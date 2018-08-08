//
//  RecentChat.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 04.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class RecentChat {
    var id: String!
    var timeStamp: Date!
    var text: String?
    var article: Article?
    var read: Bool!
    var senderUser: User!
    var receiverUser: User!
}
