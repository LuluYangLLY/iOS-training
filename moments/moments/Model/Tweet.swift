//
//  Tweet.swift
//  moments
//
//  Created by Yang Lulu  on 2020/6/25.
//  Copyright © 2020 Yang Lulu . All rights reserved.
//

import Foundation

struct Tweet: Decodable {
    var content: String?
    var images: [TweetImage]?
    var sender: [TweetSender]?
    var comments: [TweetComment]?
}

struct TweetImage: Decodable {
    var url: String
}

struct TweetSender: Decodable {
    var avatar: String
    var nick: String
    var username: String
}

struct TweetComment: Decodable {
    var content: String
    var sender: TweetSender
}
