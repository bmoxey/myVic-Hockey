//
//  DetailTeamView.swift
//  myVic Hockey
//
//  Created by Brett Moxey on 18/12/2023.
//

import SwiftUI

struct DetailTeamView: View {
var team: Teams
    var body: some View {
        Section() {
//            HeaderTextView(text: team.compName)
            VStack {
                Text(team.divType.prefix(1).uppercased() + team.divType.dropFirst())
                    .foregroundStyle(Color("DarkColor"))
                    .font(.headline)
                    
                HStack {
                    Spacer()
                    Image(team.clubName)
                        .resizable()
                        .frame(width: 45, height: 45)
                    Text(team.clubName)
                        .foregroundStyle(Color("DarkColor"))
                        .font(.title)
                    Spacer()
                }
                Text(team.divName)
                    .foregroundStyle(Color("DarkColor"))
                if team.teamName != team.clubName {
                    Text("competing as \(team.teamName)")
                        .foregroundStyle(Color("DarkColor"))
                        .font(.footnote)
                }
            }
            .overlay(
                Image(systemName: "chevron.right")
                    .font(Font.system(size: 17, weight: .semibold))
                    .foregroundColor(team.isCurrent ? Color.clear : Color("AccentColor"))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, -8)
            )
            .listRowBackground(team.isCurrent ? Color("CurrentColor") : Color.white)
            .padding(.bottom, 8)
        }
    }
        
}

