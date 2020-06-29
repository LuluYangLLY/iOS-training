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
    @IBOutlet var tweetImageColloction: UICollectionView!
    @IBOutlet var tweetCommentLabel: UILabel!

    @IBOutlet var tweetImageColloctionHeightConstraint: NSLayoutConstraint!
    
    var tweetImages: [TweetImage]!
    var collectionviewFlowLayout: UICollectionViewFlowLayout!
    
    var tweet: Tweet!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetImageColloction.dataSource = self
        tweetImageColloction.translatesAutoresizingMaskIntoConstraints = false
        tweetImageColloction.isScrollEnabled = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImage.image = nil
        nickLabel.text = nil
        contentLabel.text = nil
        tweetCommentLabel.text = nil
    }
    
    func configure(with tweet: Tweet) {
        self.tweetImageColloction.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        self.tweet = tweet

        if(tweet.sender?.avatar != nil){
            FetchService().fetchImage(urlString: tweet.sender!.avatar, imageView: self.avatarImage)
        }

        self.nickLabel.text = tweet.sender?.nick
        self.contentLabel.text = tweet.content
        self.contentLabel.numberOfLines = 0

        if(tweet.images == nil){
            self.tweetImages = []
        }else{
            self.tweetImages = tweet.images
        }
        
        self.tweetCommentLabel.text = self.formatComment()
        self.tweetCommentLabel.numberOfLines = 0
        
        self.tweetImageColloction.reloadData()
        
        self.setUpCollectionViewItemSize()
    }
    
    private func formatComment() -> String {
        guard let comments = self.tweet?.comments else { return "" }
        
        var commentStr = "";
        comments.forEach { comment in
            commentStr.append("\(comment.sender.nick): \(comment.content)\n")
        }
        
        return commentStr
    }
    
    private func setUpCollectionViewItemSize(){
        if(self.tweetImages.count == 0){
            tweetImageColloctionHeightConstraint.constant = 0
            return;
        }
        let numOfItemPerRow: CGFloat = 3
        let height: CGFloat = 80
        if self.collectionviewFlowLayout == nil {
            let lineSpacing: CGFloat = 5
            let interItemSpacing: CGFloat = 5

            let width = (self.tweetImageColloction.frame.width - (numOfItemPerRow - 1) * interItemSpacing) / numOfItemPerRow

            self.collectionviewFlowLayout = UICollectionViewFlowLayout()
            self.collectionviewFlowLayout.itemSize = CGSize(width: width, height: height)
            self.collectionviewFlowLayout.sectionInset = UIEdgeInsets.zero
            self.collectionviewFlowLayout.scrollDirection = .vertical
            self.collectionviewFlowLayout.minimumLineSpacing = lineSpacing
            self.collectionviewFlowLayout.minimumInteritemSpacing = interItemSpacing
            self.tweetImageColloction.setCollectionViewLayout(collectionviewFlowLayout, animated: true)
        }
        
        let heightOfCollection = ceil(CGFloat(self.tweetImages.count) / numOfItemPerRow) * height
        tweetImageColloctionHeightConstraint.constant = CGFloat(heightOfCollection)
    }
}

extension TableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tweetImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
            return CollectionViewCell()
        }
        cell.configure(with: self.tweetImages[indexPath.row])
        return cell
    }
}

