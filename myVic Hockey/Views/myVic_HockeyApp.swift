//
//  myVic_HockeyApp.swift
//  myVic Hockey
//
//  Created by Brett Moxey on 15/12/2023.
//


import SwiftUI
import SwiftData

@main
struct myVic_HockeyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: [Teams.self])
    }
}
