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
        let fetchService = FetchService()
        fetchService.fetchImage(urlString: profile.profileImage, imageView: self.profileImage)
        fetchService.fetchImage(urlString: profile.avatar, imageView: self.avatarImage)
        self.nickLabel.text = profile.nick
    }
    

    
}
