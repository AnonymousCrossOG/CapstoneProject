//
//  Food_FlicksApp.swift
//  Food Flicks
//
//  Created by Donis, Michael - Student on 3/6/24.
//

import SwiftUI

@main
struct Food_FlicksApp: App {
    
    @State private var library = FoodLibrary()
    @State private var userlibrary = LikedFoodLibrary()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(library)
                .environment(userlibrary)
        }
    }
}
