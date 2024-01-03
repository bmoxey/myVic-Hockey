//
//  TeamsView.swift
//  myVic Hockey
//
//  Created by Brett Moxey on 18/12/2023.
//

import SwiftUI
import SwiftData

struct TeamsView: View {
    @Environment(\.modelContext) var context
    @Query var teams: [Teams]
    @Query(filter: #Predicate<Teams> {$0.isUsed}) var usedTeams: [Teams]
    @Query(filter: #Predicate<Teams> {$0.isCurrent}) var currentTeams: [Teams]
    @State private var showingConfirmation = false
    var body: some View {
        NavigationStack {
            VStack {
                Rectangle()
                    .foregroundColor(Color("AccentColor"))
                    .frame(height: 5)
                    .shadow(color: Color("AccentColor").opacity(1.0), radius: 10, x: 0, y: 0)
                if usedTeams.isEmpty {
                    VStack {
                        Spacer()
                        Text("No teams selected")
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color("DarkColor"))
                        Spacer()
                        Spacer()
                    }
                } else {
                    List {
                        ForEach(usedTeams) { team in
                            DetailTeamView(team: team)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                usedTeams[index].isUsed = false
                            }
                        }
                    }
                    .environment(\.defaultMinListRowHeight, 10)
                    .shadow(color: Color("DarkColor").opacity(1.0) , radius: 5, x: 0, y: 0)
                }
            }
            .background(Color("BackgroundColor"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Select team")
                            .foregroundStyle(Color.white)
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SelectTeamView()) {
                        HStack {
                            Text("Add team")
                                .foregroundStyle(Color("AccentColor"))
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color("AccentColor"))
                                .font(Font.system(size: 17, weight: .semibold))
                                .frame(width: 20, height: 20)
                        }
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        VStack {
                            Image(systemName: "person.crop.circle.badge.questionmark.fill")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(Color.white, Color("AccentColor"))
                                .font(.title3)
                        }
                        Button(action: {
                            showingConfirmation = true
                        }, label: {
                            VStack {
                                Image(systemName: "arrow.counterclockwise.icloud")
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(Color.white, Color("AccentColor"))
                                Text("Rebuild")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color.white)
                            }
                        })
                        .alert("Are you sure?", isPresented: $showingConfirmation)
                        {
                            Button("Rebuild lists", role: .destructive) {
                                do {
                                    try context.delete(model: Teams.self)
                                    try context.save()
                                    try context.delete(model: Teams.self)
                                    try context.save()
                                } catch {
                                    print("failed to delete")
                                }
                                
                            }
                        } message: {
                            Text("This will delete all currently selected teams \n This process will take a minute.")
                        }
                    }
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color("DarkColor"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .accentColor(Color("AccentColor"))
            .padding(.horizontal, -8)
        }
    }
}


#Preview {
    TeamsView()
}
