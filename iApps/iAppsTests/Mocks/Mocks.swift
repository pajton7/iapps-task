//
//  Mocks.swift
//  iApps
//
//  Created by Przemysław Szlęk on 10/03/2025.
//  Copyright © 2025 Przemysław Szlęk. All rights reserved.
//

import Foundation
@testable import iApps

struct Mocks {
    static let photoItemOne = PhotoItem(
        title: "Test Photo 1",
        media: PhotoItem.Media(url: "test_url1"),
        author: "Author 1",
        authorId: "author_id1",
        published: "2000-07-07",
        dateTaken: "2000-07-06",
        tags: "tag test photo"
    )
    
    static let photoItemTwo = PhotoItem(
        title: "Test Photo 2",
        media: PhotoItem.Media(url: "test_url2"),
        author: "Author 2",
        authorId: "author_id2",
        published: "2000-07-020",
        dateTaken: "2000-07-19",
        tags: "photo tag test"
    )
}
