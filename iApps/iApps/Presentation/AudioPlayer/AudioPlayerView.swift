//
//  AudioPlayerView.swift
//  iApps
//
//  Created by Przemysław Szlęk on 09/03/2025.
//  Copyright © 2025 Przemysław Szlęk. All rights reserved.
//

import SwiftUI

struct AudioPlayerView: View {
    @State private var height: CGFloat = 100
    @State private var isExpanded = false
    @State private var sliderHeight: CGFloat = 8.0
    @State private var sliderPosition: CGFloat = 0.0
    private let minHeight: CGFloat = 100.0
    private let maxHeight: CGFloat = UIScreen.main.bounds.height / 2
    private let smallSliderHeight: CGFloat = 8.0
    private let bigSliderHeight: CGFloat = 16.0
    
    var body: some View {
        ZStack {
            if isExpanded {
                Color.black.opacity(0.5)
            }
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                    if isExpanded {
                        Text("An audio title")
                            .font(.largeTitle)
                            .padding()
                            .transition(.opacity)
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                            .font(.title2)
                            .padding()
                            .transition(.opacity)
                    }
                    
                    HStack(spacing: 40) {
                        Button { } label: { Image(systemName: "backward.fill") }
                        Button { } label: { Image(systemName: "play.fill") }
                        Button { } label: { Image(systemName: "forward.fill") }
                    }
                    .padding(.horizontal, 20)
                    
                    slider()
                }
                .padding(.top, 30)
                .padding(.horizontal, 30)
                .frame(height: height)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 10)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            let newHeight = max(minHeight, min(maxHeight, height - gesture.translation.height))
                            height = newHeight
                        }
                        .onEnded { _ in
                            if height > (minHeight + maxHeight) / 2 {
                                height = maxHeight
                                isExpanded = true
                            } else {
                                height = minHeight
                                isExpanded = false
                            }
                        }
                )
                .animation(.easeInOut, value: height)
            }
        }
        .ignoresSafeArea()
    }
    
    func slider() -> some View {
        GeometryReader { geometry in
            let sliderWidth = geometry.size.width
            ZStack {
                Capsule()
                    .fill(.gray)
                    .frame(width: sliderWidth, height: sliderHeight)
                
                Capsule()
                    .fill(.blue)
                    .frame(height: sliderHeight)
                    .mask(
                        HStack(spacing: 0) {
                            let currentWidth = max(0, min(sliderWidth, sliderPosition))
                            Capsule()
                                .frame(width: currentWidth, height: sliderHeight)
                            if currentWidth < sliderWidth {
                                Spacer()
                            }
                        }
                    )
            }
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        withAnimation {
                            sliderHeight = bigSliderHeight
                        }
                        let dragX = gesture.location.x
                        sliderPosition = max(0, min(sliderWidth, dragX))
                    }
                    .onEnded { _ in
                        withAnimation {
                            sliderHeight = smallSliderHeight
                        }
                    }
            )
        }
    }
}

#Preview {
    AudioPlayerView()
}
