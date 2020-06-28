//
//  MomentsViewModel.swift
//  moments
//
//  Created by Yang Lulu  on 2020/6/26.
//  Copyright © 2020 Yang Lulu . All rights reserved.
//

import Foundation

class MomentsViewModel {
    var didUpdateMomonts: (([Tweet]) -> Void)?
    var didUpdateProfile: ((Profile) -> Void)?
    
    var fetchService = FetchService()
    var allTweets: [Tweet] = []
        
    func fetchProfile(){
        fetchService.fetch(url: "https://emagrorrim.github.io/mock-api/user/jsmith.json"){ (profile: Profile ) in
            self.didUpdateProfile!(profile)
        }
    }
    
    func fetchMomonts(){
        fetchService.fetch(url: "https://emagrorrim.github.io/mock-api/moments.json"){ (tweets: [Tweet] ) in
            let filterTweets = tweets.filter { $0.sender != nil }
            self.didUpdateMomonts!(filterTweets)
        }
    }
    
}
