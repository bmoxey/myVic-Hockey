//
//  SelectTeamView.swift
//  myVic Hockey
//
//  Created by Brett Moxey on 19/12/2023.
//

import SwiftUI
import SwiftData

struct SelectTeamView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Teams.clubName) var teams: [Teams]
    @State private var filter = ""
    var body: some View {
//        let clubs = Array(Set(teams.map { $0.clubName }))
        var filteredClubs: [String] {
            if filter.isEmpty {
                return Array(Set(teams.map { $0.clubName })).sorted()
            } else {
                return Array(Set(teams.filter { $0.clubName.lowercased().contains(filter.lowercased()) }.map { $0.clubName })).sorted()
            }
        }
        ZStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())], spacing: 20) {
                        ForEach(filteredClubs.sorted(), id: \.self) { club in
                            VStack {
                                Text(club)
                                    .foregroundStyle(Color("DarkColor"))
                                    .font(.system(size: 12))
                                    .lineLimit(2)
                                    .frame(maxWidth: 110, maxHeight: 50)
                                    .background(Color("LightColor"))
                                Image(club)
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .padding(.vertical, 2)
                                Spacer()
                            }
                            .frame(width: 110, height: 120)
                            .background(Color("DarkColor"))
                            .cornerRadius(20)
                            .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color("AccentColor"), lineWidth: 2))
                        }
                    }
                    .padding()
                    .searchable(text: $filter)
                }
                .scrollContentBackground(.hidden)
                Rectangle()
                    .frame(height: 40)
            }
            VStack {
                Rectangle()
                    .foregroundColor(Color("AccentColor"))
                    .frame(height: 5)
                    .shadow(color: Color("AccentColor").opacity(1.0), radius: 10, x: 0, y: 0)
                Spacer()
            }
        }
        .background(Color("BackgroundColor"))
        .shadow(color: Color("DarkColor").opacity(1.0), radius: 4, x: 2, y: 2)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image("LightLogo")
                    .resizable()
                    .frame(width: 93, height: 34)
            }
            ToolbarItem(placement: .principal) {
                Text("Select your club")
                    .foregroundStyle(Color.white)
                    .fontWeight(.semibold)
            }
        }
        .toolbarBackground(Color("DarkColor"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    SelectTeamView()
}
