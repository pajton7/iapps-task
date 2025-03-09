//
//  PhotoDetailsView.swift
//  iApps
//
//  Created by Przemysław Szlęk on 07/03/2025.
//  Copyright © 2025 Przemysław Szlęk. All rights reserved.
//

import SwiftUI

struct PhotoDetailsView: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var contentHeight: CGFloat = 1
    @State private var scrollViewHeight: CGFloat = 1
    @State private var safeAreaInsets: EdgeInsets = .init()
    @State private var showPlayer: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    let photo: PhotoItem
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Image at the top
            VStack {
                AsyncImage(url: URL(string: photo.media.url)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                .overlay(
                    Color.black.opacity(min(0.7, max(0, scrollPosition()))), alignment: .bottom
                )
                .edgesIgnoringSafeArea(.top)
                Spacer()
            }
            .zIndex(1)
            
            // Scrollable text above the image
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 30) {
                    GeometryReader { proxy in
                        Color.clear
                            .frame(height: 0) // Invisible tracking area
                            .preference(key: ScrollOffsetKey.self, value: proxy.frame(in: .global).minY)
                    }
                    .frame(height: 0)
                    
                    Color.clear.frame(height: UIScreen.main.bounds.width)
            
                    titleValueView(title: "Title", value: photo.title)
                    titleValueView(title: "Link", value: photo.media.url)
                    titleValueView(title: "Date taken", value: photo.dateTaken)
                    titleValueView(title: "Published", value: photo.published)
                    titleValueView(title: "Author", value: photo.author)
                    titleValueView(title: "Author ID", value: photo.authorId)
                    titleValueView(title: "Tags", value: photo.tags)
                }
                .padding(.bottom, 20)
                .background(GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            contentHeight = proxy.size.height
                        }
                        .onChange(of: proxy.size.height) { _, newHeight in
                            contentHeight = newHeight
                        }
                })
            }
            .background(GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        scrollViewHeight = proxy.size.height
                    }
                    .onChange(of: proxy.size.height) { _, newHeight in
                        scrollViewHeight = newHeight
                    }
            })
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                scrollOffset = value
            }
            .padding(.bottom, 20 + safeAreaInsets.bottom)
            .zIndex(2)
            
            // Floating Bottom Buttons
            VStack {
                if showPlayer {
                    AudioPlayerView()
                        .transition(.move(edge: .bottom))
                }
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Home")
                            .frame(maxWidth: .infinity)
                            .frame(height: 20)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            showPlayer.toggle()
                        }
                    }) {
                        Text("Audio")
                            .frame(maxWidth: .infinity)
                            .frame(height: 20)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(.gray)
            }
            .zIndex(3)
        }
        .safeAreaInsets($safeAreaInsets)
        .navigationBarBackButtonHidden()
    }
}

private extension PhotoDetailsView {
    func scrollPosition() -> CGFloat {
        let maxScroll = max(contentHeight - scrollViewHeight, 1)
        return min(max(-scrollOffset / maxScroll, 0), 1)
    }
    
    func titleValueView(title: String, value: String) -> some View {
        VStack(spacing: 10) {
            Text(title)
                .bold()
                .font(.title)
                .foregroundStyle(.black)
            
            Text(value)
                .font(.title2)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    PhotoDetailsView(
        photo: PhotoItem(
            title: "Photo",
            media: PhotoItem.Media(url: "https://live.staticflickr.com/65535/54362646110_67bbc57689_m.jpg"),
            author: "Author",
            authorId: "200240576@N06",
            published: "2025-03-01T23:31:07Z",
            dateTaken: "2025-02-28T11:46:24-08:00",
            tags: "dog puppy maltipoo"
        )
    )
}

// PreferenceKey for tracking edge insets
struct SafeAreaInsetsKey: PreferenceKey {
    static var defaultValue = EdgeInsets()
    static func reduce(value: inout EdgeInsets, nextValue: () -> EdgeInsets) {
        value = nextValue()
    }
}

// PreferenceKey for tracking scroll offset
struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
