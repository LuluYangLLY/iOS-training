//
//  TableHeader.swift
//  moments
//
//  Created by Yang Lulu  on 2020/6/26.
//  Copyright © 2020 Yang Lulu . All rights reserved.
//

import UIKit

class TableHeader: UITableViewCell {
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var nickLabel: UILabel!
    
    func configure(with profile: Profile){
        self.profileImage = UIImageView.init(image: UIImage(named: profile.profileImage))
        self.avatarImage = UIImageView.init(image: UIImage(named: profile.avatar))
        self.nickLabel.text = profile.nick
    }
}
