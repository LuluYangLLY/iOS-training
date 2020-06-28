//
//  TableHeaderView.swift
//  moments
//
//  Created by Yang Lulu  on 2020/6/28.
//  Copyright © 2020 Yang Lulu . All rights reserved.
//

import UIKit

class TableHeaderView: UIView {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet  var nickLabel: UILabel!
        
        func configure(with profile: Profile){
            do {
                let profileUrl = URL(string: profile.profileImage)!
                let profileData = try Data(contentsOf: profileUrl)
                self.profileImage.image = UIImage(data: profileData)
                
                let avatarUrl = URL(string: profile.avatar)!
                let avatarData = try Data(contentsOf: avatarUrl)
                self.avatarImage.image = UIImage(data: avatarData)
            }
            catch {
                print(error)
            }
            self.nickLabel.text = profile.nick
        }
    

    
}
