//
//  PhotoItemView.swift
//  iApps
//
//  Created by Przemysław Szlęk on 06/03/2025.
//  Copyright © 2025 Przemysław Szlęk. All rights reserved.
//

import SwiftUI

struct PhotoItemView: View {
    var url: String
    var title: String
    private let itemSize: CGFloat = 150.0
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: url)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: itemSize, height: itemSize)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            
            Text(title)
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .padding(.bottom, 10)
        }
        .frame(maxWidth: itemSize)
    }
}

#Preview {
    PhotoItemView(
        url: "https://live.staticflickr.com/65535/54362646110_67bbc57689_m.jpg",
        title: "Mornings with Runyon & Friends - February 21st, 2025 (Ypsilanti, Michigan)"
    )
}
