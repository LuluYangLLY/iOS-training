//
//  CollectionViewCell.swift
//  moments
//
//  Created by Yang Lulu  on 2020/6/27.
//  Copyright © 2020 Yang Lulu . All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet var tweetImage: UIImageView!
    
    func configure(with tweetImage: TweetImage){
        do {
            let avatarUrl = URL(string: tweetImage.url)!
            let data = try Data(contentsOf: avatarUrl)
            self.tweetImage.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
    }
}
