//
//  TableViewCell.swift
//  moments
//
//  Created by Yang Lulu  on 2020/6/27.
//  Copyright © 2020 Yang Lulu . All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var nickLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    
    func configure(with tweet: Tweet) {
        do {
            let avatarUrl = URL(string:tweet.sender.avatar)!
            let data = try Data(contentsOf: avatarUrl)
            self.avatarImage.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
        
        self.nickLabel.text = tweet.sender.nick
        self.contentLabel.text = tweet.content
        self.contentLabel.numberOfLines = 0
    }
}

