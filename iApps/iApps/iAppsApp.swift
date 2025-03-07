//  
//  iAppsApp.swift
//  iApps
//
//  Created by Przemysław Szlęk on 05/03/2025.
//  Copyright © 2025 Przemysław Szlęk. All rights reserved.
//

import SwiftUI

@main
struct iAppsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CategoriesListView()
            }
        }
    }
}
