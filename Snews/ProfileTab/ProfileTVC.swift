//
//  ProfileTVC.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 05.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class ProfileTVC: UITableViewController, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, EditProfileProtocol {
    
    var profileImageCell = ProfileImageCell()
    var usernameCell = ProfileItemCell()
    var displayNameCell = ProfileItemCell()
    var imageData: Data?
    var username: String?
    var displayName: String?
    var editModeActive = false
    var progressHUB = ProgressHUD(text: NSLocalizedString("Updating...", comment: "--"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = NSLocalizedString("Profile", comment: "--")
        
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 180.0
        
        tableView.tableFooterView = UIView()
        TabButtons(controller: self).rightButtonText(buttonText: NSLocalizedString("Edit", comment: "--"), tempSelector: #selector(editAction))
        self.tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProfileData()
    }
    
    func getProfileData(){
        let userInstance = AuthService.instance
        imageData = userInstance.userImageData
        username = userInstance.username
        displayName = userInstance.userDisplayName
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0:
                self.profileImageCell.profileImage.image = UIImage(data: imageData!)
                return self.profileImageCell
            case 1:
                let cell = self.usernameCell
                cell.titleLbl.text = NSLocalizedString("Username", comment: "--")
                cell.valueLbl.text = username
                return cell
            case 2:
                self.displayNameCell.titleLbl.text = NSLocalizedString("Display Name", comment: "--")
                self.displayNameCell.valueLbl.text = displayName
                return self.displayNameCell
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                imageAction()
            case 1:
                print("nope")
            case 2:
                let nextVC = EditProfileVC()
                nextVC.mainText = self.displayNameCell.valueLbl.text!
                nextVC.editProfileProtocol = self
                self.navigationController?.pushViewController(nextVC, animated: true)
            default:
                print("--")
            }
        default:
            print("--")
        }
    }
    
    func updateDisplayName(displayName: String) {
        self.displayNameCell.valueLbl.text = displayName
        self.displayNameCell.hasValue = true
    }
    
    @objc func editAction(){
        TabButtons(controller: self).rightButtonText(buttonText: NSLocalizedString("Save", comment: "--"), tempSelector: #selector(saveAction))
        editModeActive = true
        self.displayNameCell.valueLbl.textColor = BLUE
        self.displayNameCell.nextImage.isHidden = false
        self.tableView.allowsSelection = true
    }
    
    @objc func saveAction(){
        updateProfile()
    }
    
    func getTheImage(type: Int){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        if type == 0 {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
        }else{
            imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        
        imagePickerController.allowsEditing = true
        imagePickerController.modalPresentationStyle = .overFullScreen
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            self.profileImageCell.profileImage.image = editedImage
            self.profileImageCell.hasValue = true
            picker.dismiss(animated: true, completion: nil)
        }else{
            let errorAlertVC = CustomAlert()
            errorAlertVC.modalPresentationStyle = .overFullScreen
            errorAlertVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            errorAlertVC.actionCallback = { (view) in
                view.dismiss(animated: true, completion: nil)
            }
            errorAlertVC.dialogTitle = NSLocalizedString("Oops", comment: "--")
            errorAlertVC.dialogImage = UIImage(named: "error")
            errorAlertVC.dialogMessage = NSLocalizedString("Looks like an error has occured, please try again later.", comment: "--")
            self.present(errorAlertVC, animated: true, completion: nil)
        }
    }
    
    func updateProfile(){
        if (self.profileImageCell.hasValue || self.displayNameCell.hasValue) && !(self.displayNameCell.valueLbl.text?.isEmpty)! {
            var displayN = ""
            if self.displayNameCell.hasValue {
                displayN = self.displayNameCell.valueLbl.text!
            }
            self.view.addSubview(progressHUB)
            let customAlert = CustomAlert()
            customAlert.modalPresentationStyle = .overFullScreen
            customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            customAlert.actionCallback = { (view) in
                view.dismiss(animated: true, completion: nil)
                self.navigationController!.popViewController(animated: true)
            }
            UserService.instance.updateProfile(userId: AuthService.instance.userId,displayName: displayN, newImage: self.profileImageCell.hasValue, image: self.profileImageCell.profileImage.image) { (success, error, message) in
                self.progressHUB.removeFromSuperview()
                if success {
                    customAlert.dialogTitle = NSLocalizedString("Success", comment: "--")
                    customAlert.dialogImage = UIImage(named: "success")
                    customAlert.dialogMessage = NSLocalizedString("Your profile was successfully updated!", comment: "--")
                    self.present(customAlert, animated: true, completion: nil)
                }else{
                    customAlert.dialogTitle = NSLocalizedString("Oops", comment: "--")
                    customAlert.dialogImage = UIImage(named: "error")
                    customAlert.dialogMessage = NSLocalizedString("Looks like an error has occured, please try again later.", comment: "--")
                    self.present(customAlert, animated: true, completion: nil)
                }
            }
        }else{
            self.navigationController!.popViewController(animated: true)
        }
    }
    
    func imageAction(){
        let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Select Profile Image", comment: "--"), message: NSLocalizedString("Select Profile Image", comment: "--"), preferredStyle: .actionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "--"), style: .cancel) { void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        let deleteActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Camera Roll", comment: "--"), style: .default)
        { void in
            self.getTheImage(type: 1)
        }
        actionSheetController.addAction(deleteActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
}
