//
//  FlickrServiceMock.swift
//  iApps
//
//  Created by Przemysław Szlęk on 10/03/2025.
//  Copyright © 2025 Przemysław Szlęk. All rights reserved.
//

import XCTest
import Combine
@testable import iApps

class MockFlickrService: FlickrServiceProvidable {
    var mockResponses: [String: Result<CategoryResponse, Error>] = [:]

    func fetchPhotos(category: String) -> AnyPublisher<CategoryResponse, Error> {
        if let result = mockResponses[category] {
            switch result {
            case .success(let response):
                return Just(response)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            case .failure(let error):
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
        }
        return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
    }
}
