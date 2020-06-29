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
        let fetchService = FetchService()
        fetchService.fetchImage(urlString: tweetImage.url, imageView: self.tweetImage)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tweetImage.image = nil
    }
}
