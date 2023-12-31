//
//  ContentView.swift
//  myVic Hockey
//
//  Created by Brett Moxey on 15/12/2023.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query var teams: [Teams]
    @State var stillLoading: Bool = false
    var body: some View {
        if teams.isEmpty || stillLoading {
            GetTeamsView(stillLoading: $stillLoading)
        } else {
            MainMenuView()
        }
    }
}

#Preview {
    ContentView()
}
