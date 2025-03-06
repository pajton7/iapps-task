//
//  CategoriesListViewModel.swift
//  iApps
//
//  Created by Przemysław Szlęk on 05/03/2025.
//  Copyright © 2025 Przemysław Szlęk. All rights reserved.
//

import Foundation
import Combine

class CategoriesListViewModel: ObservableObject {
    @Published var categoryPhotos: [String: [PhotoItem]] = [:]
    private var cancellables = Set<AnyCancellable>()
    private let flickrService: FlickrServiceProvidable
    private let categories: [String] = ["dog", "football", "formula1", "cat"]
    
    init(flickrService: FlickrServiceProvidable = FlickrService()) {
        self.flickrService = flickrService
    }
    
    func fetchAllCategories() {
        let publishers = categories.map { category in
            flickrService.fetchPhotos(category: category)
                .map { (category, $0) }
                .eraseToAnyPublisher()
        }
        
        Publishers.MergeMany(publishers)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching data: \(error)")
                }
            }, receiveValue: { [weak self] category, response in
                self?.categoryPhotos[category] = response.items
            })
            .store(in: &cancellables)
    }
}
