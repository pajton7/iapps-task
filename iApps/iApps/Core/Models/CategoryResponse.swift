//
//  FlickrResponse.swift
//  iApps
//
//  Created by Przemysław Szlęk on 05/03/2025.
//  Copyright © 2025 Przemysław Szlęk. All rights reserved.
//

import Foundation

struct CategoryResponse: Decodable {
    let title: String
    let items: [PhotoItem]
}
