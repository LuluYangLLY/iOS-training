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

    private lazy var tweetImageColloctionHeightConstraint = tweetImageColloction.heightAnchor.constraint(equalToConstant: 0)
    
    private lazy var tweetImageColloctionWidthConstraint = tweetImageColloction.widthAnchor.constraint(equalToConstant: 0)
    
    var tweetImages: [TweetImage]!
    var collectionviewFlowLayout: UICollectionViewFlowLayout!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetImageColloction.dataSource = self
        tweetImageColloction.isScrollEnabled = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImage.image = nil
        nickLabel.text = nil
        contentLabel.text = nil
        tweetCommentLabel.text = nil
        
        self.tweetImages = []
    }
    
    func configure(with tweet: Tweet) {
        self.tweetImageColloction.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
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
        
        self.tweetCommentLabel.text = self.formatComment(comments: tweet.comments ?? [])
        self.tweetCommentLabel.numberOfLines = 0
        
        self.tweetImageColloction.reloadData()
        
        self.setUpCollectionViewItemSize()
    }
    
    private func formatComment(comments: [TweetComment]) -> String {

        var commentStr = "";
        comments.forEach { comment in
            commentStr.append("\(comment.sender.nick): \(comment.content)\n")
        }
        
        return commentStr
    }
    
    private func setUpCollectionViewItemSize(){
        tweetImageColloction.translatesAutoresizingMaskIntoConstraints = false
        if(self.tweetImages.count == 0){
            tweetImageColloctionHeightConstraint.constant = 0
            tweetImageColloctionWidthConstraint.constant = 0
            NSLayoutConstraint.activate([
                tweetImageColloctionHeightConstraint,
                tweetImageColloctionWidthConstraint,
                tweetImageColloction.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 10),
                tweetImageColloction.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor)
            ])
            return;
        }
        let numOfItemPerRow: CGFloat = 3
        let lineSpacing: CGFloat = 5
        let interItemSpacing: CGFloat = 5
        
        if self.collectionviewFlowLayout == nil {
            self.collectionviewFlowLayout = UICollectionViewFlowLayout()

            self.collectionviewFlowLayout.sectionInset = UIEdgeInsets.zero
            self.collectionviewFlowLayout.scrollDirection = .vertical
            self.collectionviewFlowLayout.minimumLineSpacing = lineSpacing
            self.collectionviewFlowLayout.minimumInteritemSpacing = interItemSpacing
            self.tweetImageColloction.setCollectionViewLayout(collectionviewFlowLayout, animated: true)
        }
        
        let size = self.getItemSize()
        self.collectionviewFlowLayout.itemSize = CGSize(width: size, height: size)
        
        let sizeOfCollectionView = self.getSizeForCollectionView(lineSpacing: lineSpacing, interItemSpacing: interItemSpacing, numOfItemPerRow: numOfItemPerRow)
        tweetImageColloctionHeightConstraint.constant = sizeOfCollectionView.0
        tweetImageColloctionWidthConstraint.constant = sizeOfCollectionView.1
        
        NSLayoutConstraint.activate([
            tweetImageColloctionHeightConstraint,
            tweetImageColloctionWidthConstraint,
            tweetImageColloction.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 10),
            tweetImageColloction.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor)
        ])
    }
    
    private func getItemSize() -> CGFloat {
        let count = self.tweetImages.count;
        if(count == 1){
            return CGFloat(120)
        }
        if(count == 4){
            return CGFloat(100)
        }
        return CGFloat(80)
    }
    
    private func getSizeForCollectionView(lineSpacing: CGFloat, interItemSpacing:CGFloat, numOfItemPerRow: CGFloat) -> (CGFloat, CGFloat) {
        let size = self.getItemSize()
        let count = self.tweetImages.count;
        if(count == 1){
            return (size, size)
        }
        if(count == 4){
            return (size * 2 + lineSpacing, size * 2 + interItemSpacing)
        }
        let rowOfCollection = ceil(CGFloat(self.tweetImages.count) / numOfItemPerRow)
        let height = rowOfCollection * size + (rowOfCollection - 1) * lineSpacing
        let width = numOfItemPerRow * size + (numOfItemPerRow - 1) * interItemSpacing
        return (height, width)
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

