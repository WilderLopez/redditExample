//
//  Model.swift
//  TestingReddit
//
//  Created by Wilder López on 5/15/23.
//

import Foundation


struct Post: Identifiable {
    var id: String
    var title: String
    var author: String
    var url: String
    let thumbnailUrl: URL?
    let fullImageUrl: URL?
    var subredditNamePrefixed: String
    var created: TimeInterval
    var numComments: Int
}


extension Post: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case url
        case thumbnailUrl = "thumbnail"
        case fullImageUrl = "url_overridden_by_dest"
        case subredditNamePrefixed = "subreddit_name_prefixed"
        case data
        case created = "created"
        case numComments = "num_comments"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        id = try dataContainer.decode(String.self, forKey: .id)
        title = try dataContainer.decode(String.self, forKey: .title)
        author = try dataContainer.decode(String.self, forKey: .author)
        url = try dataContainer.decode(String.self, forKey: .url)
        
        let thumbnailString = try dataContainer.decode(String.self, forKey: .thumbnailUrl)
        thumbnailUrl = URL(string: thumbnailString)
        
        let fullImageString = try dataContainer.decode(String.self, forKey: .fullImageUrl)
        fullImageUrl = URL(string: fullImageString)

        subredditNamePrefixed = try dataContainer.decode(String.self, forKey: .subredditNamePrefixed)
        created = try dataContainer.decode(TimeInterval.self, forKey: .created)
        numComments = try dataContainer.decode(Int.self, forKey: .numComments)
    }
}


struct Listing {
    var posts = [Post]()
}

// MARK: - Decodable
extension Listing: Decodable {
    enum CodingKeys: String, CodingKey {
        case posts = "children"
        
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let data = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        posts = try data.decode([Post].self, forKey: .posts)
    }
}
