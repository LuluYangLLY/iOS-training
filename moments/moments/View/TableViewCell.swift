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
    
    var tweetImages: [TweetImage]!
    var collectionviewFlowLayout: UICollectionViewFlowLayout!
    
    var tweet: Tweet!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetImageColloction.dataSource = self
    }
    
    func configure(with tweet: Tweet) {
        self.tweetImageColloction.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        self.tweet = tweet

        do {
            let avatarUrl = URL(string: tweet.sender?.avatar ?? "")!
            let data = try Data(contentsOf: avatarUrl)
            self.avatarImage.image = UIImage(data: data)
        }
        catch {
            print(error)
        }
        
        self.nickLabel.text = tweet.sender?.nick
        self.contentLabel.text = tweet.content
        self.contentLabel.numberOfLines = 0
        self.tweetImages = tweet.images

        self.tweetCommentLabel.text = self.formatComment()
        self.tweetCommentLabel.numberOfLines = 0
        
        self.setUpCollectionViewItemSize()
    }
    
    private func formatComment() -> String {
        guard let comments = self.tweet?.comments else { return "" }
        
        var commentStr = "";
        comments.forEach { comment in
            commentStr.append(" \(comment.sender.nick):  \(comment.content)\n")
        }
        
        return commentStr
    }
    
    private func setUpCollectionViewItemSize(){
        if self.collectionviewFlowLayout == nil {
            let numOfItemPerRow: CGFloat = 3
            let lineSpacing: CGFloat = 5
            let interItemSpacing: CGFloat = 5

            let width = (self.tweetImageColloction.frame.width - (numOfItemPerRow - 1) * interItemSpacing) / numOfItemPerRow

            let height = width

            self.collectionviewFlowLayout = UICollectionViewFlowLayout()
            self.collectionviewFlowLayout.itemSize = CGSize(width: width, height: height)
            self.collectionviewFlowLayout.sectionInset = UIEdgeInsets.zero
            self.collectionviewFlowLayout.scrollDirection = .vertical
            self.collectionviewFlowLayout.minimumLineSpacing = lineSpacing
            self.collectionviewFlowLayout.minimumInteritemSpacing = interItemSpacing
            self.tweetImageColloction.setCollectionViewLayout(collectionviewFlowLayout, animated: true)
        }
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

