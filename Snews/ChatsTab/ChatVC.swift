//
//  ChatVC.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 04.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, ArticleProtocol {
    
    lazy var tableView : UITableView = {
        let view = UITableView(frame: .zero, style: UITableViewStyle.plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ChatCell.self, forCellReuseIdentifier: "ChatCell")
        view.register(OtherChatCell.self, forCellReuseIdentifier: "OtherChatCell")
        view.register(ChatArticleCell.self, forCellReuseIdentifier: "ChatArticleCell")
        view.register(OtherChatArticleCell.self, forCellReuseIdentifier: "OtherChatArticleCell")
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    var constantBottom = NSLayoutYAxisAnchor()
    
    let inputBoxView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    var inputTextView: UITextView = {
        let view = UITextView()
        view.font = FONTS().normal(16)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autocorrectionType = .no
        return view
    }()
    
    let seperatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sendBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "send"), for: .normal)
        btn.tintColor = BLUE
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        return btn
    }()
    
    let mLbl = UILabel(frame: CGRect(x: 5, y: 2, width: 200, height: 18))
    let font = FONTS().normal(17)
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    
    var inputViewHeight1: NSLayoutConstraint?
    var bottomConstraint1 : NSLayoutConstraint?
    
    var recentChat: RecentChat?
    var messages = [Message]()
    var userId: String?
    var otherUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        userId = AuthService.instance.userId
        //tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        tableView.layoutMargins = .zero
        tableView.tableFooterView = UIView()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 180.0
        
        inputTextView.delegate = self
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        self.view.addSubview(inputBoxView)
        self.view.addSubview(seperatorLine)
        self.inputBoxView.addSubview(sendBtn)
        self.inputBoxView.addSubview(inputTextView)
        
        inputBoxView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        inputBoxView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        inputBoxView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        //inputBoxView.heightAnchor.constraint(equalToConstant: 46).isActive = true
        inputBoxView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        seperatorLine.bottomAnchor.constraint(equalTo: self.inputBoxView.topAnchor).isActive = true
        seperatorLine.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        seperatorLine.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        seperatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.seperatorLine.topAnchor).isActive = true
        
        sendBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        sendBtn.bottomAnchor.constraint(equalTo: self.inputBoxView.bottomAnchor, constant: -8).isActive = true
        sendBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        sendBtn.trailingAnchor.constraint(equalTo: self.inputBoxView.trailingAnchor, constant: -8).isActive = true
        sendBtn.tintColor = BLUE
        
        sendBtn.alpha = 0.3
        sendBtn.isEnabled = false
        
        inputTextView.topAnchor.constraint(equalTo: self.inputBoxView.topAnchor, constant: TOP_CONSTANT).isActive = true
        inputTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: LEFT_CONSTANT_IN).isActive = true
        inputTextView.trailingAnchor.constraint(equalTo: self.sendBtn.leadingAnchor, constant: RIGHT_CONSTANT_IN).isActive = true
        inputTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 36).isActive = true
        inputTextView.bottomAnchor.constraint(equalTo: self.inputBoxView.bottomAnchor, constant: BOTTOM_CONSTANT).isActive = true
        
        mLbl.text = "Type a message..."
        mLbl.backgroundColor = UIColor.clear
        mLbl.textColor = UIColor.lightGray
        mLbl.font = FONTS().normal(16)
        inputTextView.addSubview(mLbl)
        inputTextView.isScrollEnabled = false
        inputTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        // Do any additional setup after loading the view.
        //NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        // Keyboard stuff.
        let center: NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(ChatVC.keyboardWillChange), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(ChatVC.keyboardWillChange), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        center.addObserver(self, selector: #selector(ChatVC.keyboardWillChange), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        otherUser = recentChat?.senderUser
        if recentChat?.senderUser.id == self.userId {
            otherUser = recentChat?.receiverUser
        }
        self.navigationItem.title = otherUser?.displayName
    }
    
    deinit {
        let center: NotificationCenter = NotificationCenter.default
        center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            view.frame.origin.y = -keyboardRect.height
        }else{
            view.frame.origin.y = 0
        }
    }
    
    func hideKeyboard(){
        inputTextView.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        listenOnSocket()
        getMessages()
    }
    
    func getMessages(){
        MessageService.instance.getChatRoomMessages(userId: userId!, chatRoomId: (recentChat?.id)!) { (success, error, message, newMessages) in
            if success {
                if let newMessages = newMessages {
                    self.messages = newMessages
                }
                self.reloadData()
            }
        }
    }
    
    func listenOnSocket(){
        SocketService.instance.socket?.on(userId!) { (dataArray, sockectEmitter) in
            
            let typeInt = dataArray[0] as? Int
            let chatRoomId = dataArray[1] as? String
            if self.recentChat?.id == chatRoomId {
                let savedMessage = dataArray[2] as? Dictionary<String,Any>
                let newMessage = Parsers().convertDictionaryToMessage(jsonMessage: savedMessage!)
                self.readMessage(messageId: newMessage.id)
                self.messages.append(newMessage)
                self.tableView.beginUpdates()
                let indexPath:IndexPath = IndexPath(row:(self.messages.count - 1), section:0)
                self.tableView.insertRows(at: [indexPath], with: .bottom)
                self.tableView.endUpdates()
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    func readMessage(messageId: String){
        MessageService.instance.readMessage(messageId: messageId) { (success, error, message) in
            if success {
                print("Message updated")
            }
        }
    }
    
    //MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.messages[indexPath.row]
        if let article = message.article {
            if message.senderUser.id == userId {
                let chatArticleCell = tableView.dequeueReusableCell(withIdentifier: "ChatArticleCell", for: indexPath) as? ChatArticleCell
                chatArticleCell?.messageView.tag = indexPath.row
                chatArticleCell?.articleProtocol = self
                chatArticleCell?.providerImage.image = UIImage(named: article.company.name)
                chatArticleCell?.providerName.text = article.company.name
                chatArticleCell?.articleTitle.text = article.title
                if let imageUrl = article.imageUrl {
                    let url = URL(string: imageUrl)
                    chatArticleCell?.articleImage.af_setImage(withURL: url!)
                }
                chatArticleCell?.timeStamp.text = customDates().recentDate(message.timeStamp)
                if message.read {
                    chatArticleCell?.readImage.tintColor = BLUE
                }else{
                    chatArticleCell?.readImage.tintColor = UIColor.gray
                }
                return chatArticleCell!
            }else{
                let otherChatArticleCell = tableView.dequeueReusableCell(withIdentifier: "OtherChatArticleCell", for: indexPath) as? OtherChatArticleCell
                otherChatArticleCell?.messageView.tag = indexPath.row
                otherChatArticleCell?.articleProtocol = self
                otherChatArticleCell?.providerImage.image = UIImage(named: article.company.name)
                otherChatArticleCell?.providerName.text = article.company.name
                otherChatArticleCell?.articleTitle.text = article.title
                if let imageUrl = article.imageUrl {
                    let url = URL(string: imageUrl)
                    otherChatArticleCell?.articleImage.af_setImage(withURL: url!)
                }
                otherChatArticleCell?.timeStamp.text = customDates().recentDate(message.timeStamp)
                return otherChatArticleCell!
            }
        }else{
            
            if message.senderUser.id == userId {
                let chatCell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as? ChatCell
                chatCell?.messageView.tag = indexPath.row
                chatCell?.messageText.text = message.message
                chatCell?.timeStamp.text = customDates().recentDate(message.timeStamp)
                if message.read {
                    chatCell?.readImage.tintColor = BLUE
                }else{
                    chatCell?.readImage.tintColor = UIColor.gray
                }
                return chatCell!
            }else{
                let otherChatCell = tableView.dequeueReusableCell(withIdentifier: "OtherChatCell", for: indexPath) as? OtherChatCell
                otherChatCell?.messageView.tag = indexPath.row
                otherChatCell?.messageText.text = message.message
                otherChatCell?.timeStamp.text = customDates().recentDate(message.timeStamp)
                return otherChatCell!
            }
        }
    }
    
    func reloadData(){
        tableView.reloadData()
        DispatchQueue.main.async { // Correct
            let scrollPoint = CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.frame.size.height)
            self.tableView.setContentOffset(scrollPoint, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0)
        if indexPath.row == lastRowIndex - 1 {
            tableView.scrollToBottom(animated: true)
        }
    }

    @objc func sendAction(){
        MessageService.instance.sendTextMessage(senderId: self.userId!, receiverId: (otherUser?.id)!, text: inputTextView.text) { (success, error, message,newMessage) in
            if success {
                if let newMessage = newMessage {
                    self.messages.append(newMessage)
                    self.tableView.beginUpdates()
                    let indexPath:IndexPath = IndexPath(row:(self.messages.count - 1), section:0)
                    self.tableView.insertRows(at: [indexPath], with: .bottom)
                    self.tableView.endUpdates()
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    self.inputTextView.text = ""
                }
            }else{
                print("Error message not sent")
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if inputTextView.text.isEmpty {
            sendBtn.alpha = 0.3
            sendBtn.isEnabled = false
            inputTextView.addSubview(mLbl)
        }else{
            sendBtn.alpha = 1
            sendBtn.isEnabled = true
            mLbl.removeFromSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //self.view.endEditing(true)
    }
    
    func viewArticle(index: Int) {
        let message = self.messages[index]
        if let article = message.article {
            let nextVC = ArticleWebViewVC()
            nextVC.article = article
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension UITableView {
    func scrollToBottom(animated: Bool = true) {
        let sections = self.numberOfSections
        let rows = self.numberOfRows(inSection: sections - 1)
        if (rows > 0){
            self.scrollToRow(at: NSIndexPath(row: rows - 1, section: sections - 1) as IndexPath, at: .bottom, animated: true)
        }
    }
}
