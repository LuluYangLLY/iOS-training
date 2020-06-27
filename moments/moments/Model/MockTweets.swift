//
//  MockTweets.swift
//  moments
//
//  Created by Yang Lulu  on 2020/6/27.
//  Copyright © 2020 Yang Lulu . All rights reserved.
//

import Foundation

let mockTweets = [
    Tweet(
      content: "沙发！",
      sender: TweetSender(
          username: "xinguo",
          nick: "Xin Guo",
          avatar: "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/001.jpeg"
        ),
      images: [
        TweetImage(url: "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/007.jpeg"),
        TweetImage(url: "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/008.jpeg"),
        TweetImage(url: "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/009.jpeg"),
        TweetImage(url: "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/010.jpeg"),
      ]
    ),
    Tweet(
      content: "Test Test！",
      sender: TweetSender(
          username: "yanzi",
          nick: "Yanzi Li",
          avatar: "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/008.jpeg"
      ),
      images: [
        TweetImage(url: "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/001.jpeg")
      ]
    )
]


