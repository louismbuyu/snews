//
//  SocketService.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 07.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    //var socketMangerSpec = SocketManagerSpec()
    var socket : SocketIOClient?
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
    
    func establishConnection() {
        socket = manager.defaultSocket
        socket?.connect()
    }
    
    func closeConnection() {
        socket?.disconnect()
    }
}
