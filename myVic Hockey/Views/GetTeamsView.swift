//
//  GetTeamsView.swift
//  myVic Hockey
//
//  Created by Brett Moxey on 15/12/2023.
//

import SwiftUI

struct GetTeamsView: View {
    @Environment(\.modelContext) var context
    @Binding var stillLoading: Bool
    @State private var divsDone: Double = 0.0
    @State private var totalDivs: Double = 100.0
    var body: some View {
        LoadingView(done: $divsDone, total: $totalDivs)
        .onAppear() {
            Task {
                stillLoading = true
                await GetTeams()
            }
        }
    }
    func GetTeams() async {
        var compName = ""
        var compID = ""
        var divName = ""
        var divID = ""
        var lines: [String] = []
        var newlines: [String] = []
        var filtered: [String]
        lines = GetUrl(url: "https://www.hockeyvictoria.org.au/games/")
        filtered = lines.filter { $0.contains("https://www.hockeyvictoria.org.au/games") }
        self.totalDivs = Double(filtered.count)
        for i in 0..<lines.count {
            if lines[i].contains("https://www.hockeyvictoria.org.au/reports/games/download/") {
                compName = lines[i-4]
                compID = String(lines[i].split(separator: "=")[4]).trimmingCharacters(in: .punctuationCharacters)
            }
            if lines[i].contains("/games/\(compID)/") {
                divName = ShortDivName(fullName: String(lines[i+1]))
                divID = String(lines[i].split(separator: "=")[2]).trimmingCharacters(in: .punctuationCharacters)
                newlines = GetUrl(url: "https://www.hockeyvictoria.org.au/games/\(compID)/&r=9&d=\(divID)")
                for j in 0 ..< newlines.count {
                    if newlines[j].contains("https://www.hockeyvictoria.org.au/teams") {
                        let teamName = ShortTeamName(fullName: newlines[j+1])
                        let teamID = String(String(newlines[j].split(separator: "=")[2]).trimmingCharacters(in: .punctuationCharacters))
                        let clubName = ShortClubName(fullName: teamName)
                        let divLevel = GetDivLevel(fullString: divName)
                        let divType = GetDivType(fullName: divName)
                        let team = Teams(id: Int(teamID) ?? 0, compName: compName, compID: compID, divName: divName, divID: divID, divLevel: divLevel, divType: divType, teamName: teamName, teamID: teamID, clubName: clubName, isCurrent: false, isUsed: false)
                        context.insert(team)
                    }
                }
                self.divsDone += 1.0
            }
        }
        self.stillLoading = false

    }
}

#Preview {
    GetTeamsView(stillLoading: .constant(true))
}
