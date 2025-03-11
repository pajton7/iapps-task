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
    private let categories: [String]// = ["dog", "football", "formula1", "cat"]
    let allCategoriesFetched = PassthroughSubject<Void, Never>()
    
    init(flickrService: FlickrServiceProvidable = FlickrService(), categories: [String] = ["dog", "football", "formula1", "cat"]) {
        self.flickrService = flickrService
        self.categories = categories
    }
    
    func fetchAllCategories() {
        let publishers = categories.map { category in
            flickrService.fetchPhotos(category: category)
                .map { (category, $0) }
                .eraseToAnyPublisher()
        }
        
        var receivedCount = 0
        
        Publishers.MergeMany(publishers)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching data: \(error)")
                }
            }, receiveValue: { [weak self] category, response in
                self?.categoryPhotos[category] = response.items
                receivedCount += 1
                
                // Notify when all categories are fetched
                if receivedCount == self?.categories.count {
                    self?.allCategoriesFetched.send()
                }
            })
            .store(in: &cancellables)
    }
}
