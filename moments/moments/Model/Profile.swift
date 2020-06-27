//
//  Profile.swift
//  moments
//
//  Created by Yang Lulu  on 2020/6/26.
//  Copyright © 2020 Yang Lulu . All rights reserved.
//

import Foundation

struct Profile: Decodable {
    var profileImage: String;
    var avatar: String;
    var nick: String;
    var username: String;
    
    enum CodingKeys: String, CodingKey {
        case profileImage = "profile-image"

        case avatar, nick, username
    }
}
