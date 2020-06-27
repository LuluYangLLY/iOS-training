//
//  Tweet.swift
//  moments
//
//  Created by Yang Lulu  on 2020/6/25.
//  Copyright © 2020 Yang Lulu . All rights reserved.
//

import Foundation

public struct Tweet: Decodable {
    var content: String
//    var images: [TweetImage]?
//    var sender: [TweetSender]?
//    var comments: [TweetComment]?
}

public struct TweetImage: Codable {
    var url: String
}

public struct TweetSender: Codable {
    var avatar: String
    var nick: String
    var username: String
}

public struct TweetComment: Codable {
    var content: String
    var sender: TweetSender
}
