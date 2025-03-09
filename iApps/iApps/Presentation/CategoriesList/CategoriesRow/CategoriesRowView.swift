//
//  CategoriesRowView.swift
//  iApps
//
//  Created by Przemysław Szlęk on 05/03/2025.
//  Copyright © 2025 Przemysław Szlęk. All rights reserved.
//

import SwiftUI

struct CategoriesRowView: View {
    var category: String
    var items: [PhotoItem]
    @State private var isPresented = false
    @State private var selectedItem: PhotoItem?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)
                .padding(.leading, 10)
            
            ScrollView(.horizontal) {
                HStack(spacing: 15) {
                    ForEach(items, id: \.id) { item in
                        NavigationLink {
                            PhotoDetailsView(photo: item)
                        } label: {
                            PhotoItemView(
                                url: item.media.url,
                                title: item.title
                            )
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    CategoriesRowView(
        category: "test",
        items: [
            PhotoItem(
                title: "Photo",
                media: PhotoItem.Media(url: "https://live.staticflickr.com/65535/54362646110_67bbc57689_m.jpg"),
                author: "Author",
                authorId: "",
                published: "",
                dateTaken: "",
                tags: ""
            )
        ]
    )
}
