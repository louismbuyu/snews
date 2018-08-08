//
//  ProfileTabTVC.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 04.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import UIKit

class ProfileTabTVC: UITableViewController {
    
    var profileHeaderCell = ProfileTabHeaderCell()
    var settingsCell = ProfileTabOptionCell()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = NSLocalizedString("Profile", comment: "--")
        
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        
        tableView.tableFooterView = UIView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0:
                //let cell = self.profileHeaderCell
                self.profileHeaderCell.titleLbl.text = NSLocalizedString("View Profile", comment: "--")
                //return cell
                return self.profileHeaderCell
            case 1:
                let cell = self.settingsCell
                cell.titleLbl.text = NSLocalizedString("Settings", comment: "--")
                cell.optionImage.image = UIImage(named: "settings")
                return cell
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0:
                return 100
            case 1:
                return 60
            default:
                return 0
            }
        default:
            return 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProfileData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0:
                //profile
                let nextVC = ProfileTVC()
                self.navigationController?.pushViewController(nextVC, animated: true)
            case 1:
                //Settings
                let nextVC = SettingsVC()
                self.navigationController?.pushViewController(nextVC, animated: true)
            default:
                print("Default")
            }
        default:
            print("nope")
        }
    }
    
    func getProfileData(){
        let userInstance = AuthService.instance
        let imageDate = userInstance.userImageData
        self.profileHeaderCell.profileImage.image = UIImage(data: imageDate)
        self.profileHeaderCell.profileNameLbl.text = userInstance.userDisplayName
    }

}
