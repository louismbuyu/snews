//
//  RecentChatsTVC.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 04.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import UIKit

class RecentChatsTVC: UITableViewController {
    
    var recentChats = [RecentChat]()
    var userId: String?
    var progressHUB = ProgressHUD(text: "Loading...")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userId = AuthService.instance.userId
        self.navigationItem.title = "Chats"
        tableView.register(RecentChatsCell.self, forCellReuseIdentifier: "RecentChatsCell")
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 180.0
        listenOnSocket()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        getRecentChats()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recentChats.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentChatsCell", for: indexPath) as? RecentChatsCell

        let recentChat = self.recentChats[indexPath.row]
        var otherUser = User()
        if userId == recentChat.senderUser.id {
            otherUser = recentChat.receiverUser
        }else{
            otherUser = recentChat.senderUser
        }
        
        if let imageUrl = otherUser.imageUrl {
            let url = URL(string: imageUrl)
            cell?.profileImageView.af_setImage(withURL: url!)
        }
        
        cell?.usernameLbl.text = otherUser.displayName
        cell?.timeStampLbl.text = customDates().recentDate(recentChat.timeStamp)
        
        cell?.lastMessageLbl.text = recentChat.text
        
        if recentChat.read {
            if userId == recentChat.senderUser.id {
                if let imageUrl = otherUser.imageUrl {
                    let url = URL(string: imageUrl)
                    cell?.readProfileImageView.af_setImage(withURL: url!)
                }
                cell?.readProfileImageView.layer.borderWidth = 1
                cell?.readProfileImageView.isHidden = false
            }else{
                cell?.readProfileImageView.isHidden = true
            }
        }else{
            if userId == recentChat.senderUser.id {
                cell?.readProfileImageView.isHidden = true
            }else{
                cell?.readProfileImageView.image = UIImage(named: "new")
                cell?.readProfileImageView.layer.borderWidth = 0
                cell?.readProfileImageView.isHidden = false
            }
        }

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nextVC = ChatVC()
        nextVC.recentChat = self.recentChats[indexPath.row]
        nextVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func getRecentChats(){
        progressHUB.show()
        MessageService.instance.getRecentChats(userId: userId!) { (success, error, message, newRecentChats) in
            self.progressHUB.hide()
            if success {
                if let newRecentChats = newRecentChats {
                    self.recentChats = newRecentChats
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func listenOnSocket(){
        SocketService.instance.socket?.on(userId!) { (dataArray, sockectEmitter) in
            for item in dataArray {
                print("Item: \(item)")
            }
            let typeInt = dataArray[0] as? Int
            let chatRoomId = dataArray[1] as? String
            let savedMessage = dataArray[2] as? Dictionary<String,Any>
            let senderUser = dataArray[3] as? Dictionary<String,Any>
            let receiverUser = dataArray[4] as? Dictionary<String,Any>
            
            let newRecentChat = RecentChat()
            newRecentChat.id = chatRoomId
            let newMessage = Parsers().convertDictionaryToMessage(jsonMessage: savedMessage!)
            newRecentChat.text = newMessage.message
            newRecentChat.read = newMessage.read
            newRecentChat.timeStamp = newMessage.timeStamp
            newRecentChat.senderUser = Parsers().convertDictionaryToUser(user: senderUser!)
            newRecentChat.receiverUser = Parsers().convertDictionaryToUser(user: receiverUser!)
            
            if let i = self.recentChats.index(where: { $0.id == chatRoomId }){
                self.recentChats.remove(at: i)
                self.tableView.beginUpdates()
                let indexPathDelete:IndexPath = IndexPath(row:i, section:0)
                self.tableView.deleteRows(at: [indexPathDelete], with: .left)
                self.tableView.endUpdates()
            }
            self.recentChats.insert(newRecentChat, at: 0)
            self.tableView.beginUpdates()
            let indexPath:IndexPath = IndexPath(row:0, section:0)
            self.tableView.insertRows(at: [indexPath], with: .top)
            self.tableView.endUpdates()
        }
    }

}
