# iapps-task

Overview

This application fetches and displays categorized photos from Flickr. It is built using SwiftUI and Combine for reactive programming. The app retrieves images for predefined categories (e.g., "dog", "football", "formula1", "cat") and dynamically updates the UI as data is fetched.

Technologies Used

SwiftUI – for UI development
Combine – for handling asynchronous data streams
Networking – fetching data from Flickr API
Unit Testing – ensuring functionality with XCTest and Combine testing

Architecture & Design decisions

- Fetching data
The app uses Combine to fetch images for all categories in parallel.
Publishers.MergeMany combines multiple API requests, ensuring a non-blocking UI.
Data updates progressively (categories are populated as they load).
- Testability
Introduced allCategoriesFetched publisher to notify when all data is loaded.
MockFlickrService allows testing without real API calls.
