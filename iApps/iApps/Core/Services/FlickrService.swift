//
//  FlickrService.swift
//  iApps
//
//  Created by Przemysław Szlęk on 05/03/2025.
//  Copyright © 2025 Przemysław Szlęk. All rights reserved.
//

import Foundation
import Combine

protocol FlickrServiceProvidable {
    func fetchPhotos(category: String) -> AnyPublisher<CategoryResponse, Error>
}

class FlickrService: FlickrServiceProvidable {
    func fetchPhotos(category: String) -> AnyPublisher<CategoryResponse, Error> {
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=\(category)&nojsoncallback=1"
        
        guard let url = URL(string: urlString) else { return Fail(error: URLError(.badURL)).eraseToAnyPublisher() }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CategoryResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
