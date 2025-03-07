//
//  UIView+EdgeInsets.swift
//  iApps
//
//  Created by Przemysław Szlęk on 09/03/2025.
//  Copyright © 2025 Przemysław Szlęk. All rights reserved.
//

import SwiftUI

extension View {
    func safeAreaInsets(_ safeInsets: Binding<EdgeInsets>) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: SafeAreaInsetsKey.self, value: proxy.safeAreaInsets)
            }
            .onPreferenceChange(SafeAreaInsetsKey.self) { value in
                safeInsets.wrappedValue = value
            }
        )
    }
}
