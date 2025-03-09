//
//  FlickrItem.swift
//  iApps
//
//  Created by Przemysław Szlęk on 05/03/2025.
//  Copyright © 2025 Przemysław Szlęk. All rights reserved.
//

import Foundation

struct PhotoItem: Decodable {
    let title: String
    let media: Media
    let author: String
    let authorId: String
    let published: String
    let dateTaken: String
    let tags: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case media
        case author
        case authorId = "author_id"
        case published
        case dateTaken = "date_taken"
        case tags
    }
    
    struct Media: Decodable {
        let url: String
        
        enum CodingKeys: String, CodingKey {
            case url = "m"
        }
    }
}

extension PhotoItem: Identifiable {
    var id: UUID { return UUID() }
}
