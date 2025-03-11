//
//  CategoriesListViewModelTests.swift
//  iApps
//
//  Created by Przemysław Szlęk on 10/03/2025.
//  Copyright © 2025 Przemysław Szlęk. All rights reserved.
//

import XCTest
import Combine
@testable import iApps

class CategoriesListViewModelTests: XCTestCase {
    var viewModel: CategoriesListViewModel!
    var mockService: MockFlickrService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockService = MockFlickrService()
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchAllCategoriesSuccess() {
        // Given
        let testCategories = ["music", "art"]
        viewModel = CategoriesListViewModel(flickrService: mockService, categories: testCategories)
        mockService.mockResponses["music"] = .success(CategoryResponse(title: "music", items: [Mocks.photoItemOne]))
        mockService.mockResponses["art"] = .success(CategoryResponse(title: "art", items: [Mocks.photoItemOne, Mocks.photoItemTwo]))

        let expectation = XCTestExpectation(description: "Fetch categories successfully")

        // When
        viewModel.fetchAllCategories()

        viewModel.allCategoriesFetched
            .sink {
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 2.0)
        
        XCTAssertEqual(viewModel.categoryPhotos.count, testCategories.count, "Should have exactly \(testCategories.count) categories")
        XCTAssertEqual(viewModel.categoryPhotos["music"]?.count, 1, "music category should have 1 photo")
        XCTAssertEqual(viewModel.categoryPhotos["art"]?.count, 2, "art category should have 2 photos")
    }
    
    func testFetchAllCategoriesFailure() {
        // Given
        let testCategories = ["music", "art"]
        viewModel = CategoriesListViewModel(flickrService: mockService, categories: testCategories)
        
        for category in testCategories {
            mockService.mockResponses[category] = .failure(URLError(.notConnectedToInternet))
        }
        
        let expectation = XCTestExpectation(description: "Handle API failure correctly")
        
        // When
        viewModel.fetchAllCategories()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            // Then
            XCTAssertTrue(self?.viewModel.categoryPhotos.isEmpty ?? false, "categoryPhotos should be empty on failure")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchAllCategoriesEmptyResponse() {
        // Given
        let testCategories = ["music", "art"]
        viewModel = CategoriesListViewModel(flickrService: mockService, categories: testCategories)
        for category in testCategories {
            mockService.mockResponses[category] = .success(CategoryResponse(title: category, items: []))
        }
        
        let expectation = XCTestExpectation(description: "Handle empty response correctly")
        
        // When
        viewModel.fetchAllCategories()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            // Then
            XCTAssertEqual(self?.viewModel.categoryPhotos.count, testCategories.count, "Should still have \(testCategories.count) categories")
            XCTAssertTrue(self?.viewModel.categoryPhotos["music"]?.isEmpty ?? false, "music category should be empty")
            XCTAssertTrue(self?.viewModel.categoryPhotos["art"]?.isEmpty ?? false, "art category should be empty")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}
