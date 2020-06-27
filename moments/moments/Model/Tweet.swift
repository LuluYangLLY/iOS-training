//
//  Tweet.swift
//  moments
//
//  Created by Yang Lulu  on 2020/6/25.
//  Copyright © 2020 Yang Lulu . All rights reserved.
//

import Foundation
import UIKit

 public struct Tweet: Decodable {
    var content: String
    var sender: TweetSender
 }

// public struct Tweet: Decodable {
//    var content: String?
//    var images: [TweetImage]?
//    var sender: TweetSender?
//    var comments: [TweetComment]?
// }

public struct TweetImage: Codable {
    var url: String
}

public struct TweetSender: Codable {
    var username: String
    var nick: String
    var avatar: String
}

public struct TweetComment: Codable {
    var content: String
    var sender: TweetSender
}
