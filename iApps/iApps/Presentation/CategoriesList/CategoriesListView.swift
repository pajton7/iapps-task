//
//  CategoriesListView.swift
//  iApps
//
//  Created by Przemysław Szlęk on 05/03/2025.
//  Copyright © 2025 Przemysław Szlęk. All rights reserved.
//

import SwiftUI

struct CategoriesListView: View {
    @StateObject var viewModel = CategoriesListViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.categoryPhotos.keys.sorted(), id: \.self) { category in
                    CategoriesRowView(category: category.capitalized, items: viewModel.categoryPhotos[category] ?? [])
                }
            }
        }
        .task {
            viewModel.fetchAllCategories()
        }
    }
}

#Preview {
    CategoriesListView()
}
