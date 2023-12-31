//
//  LoadingView.swift
//  myVic Hockey
//
//  Created by Brett Moxey on 15/12/2023.
//

import SwiftUI

struct LoadingView: View {
    @Binding var done: Double
    @Binding var total: Double
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image("HVText")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 2/3)
                Spacer()
                Image("HVPlayer")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 2/3)
                Spacer()
                ProgressView("Loading ...",value: Double(done), total: Double(total))
                    .foregroundStyle(Color("DarkColor"))
                    .padding()
                Spacer()
            }
        }
        .background(Color("DarkColor").gradient)
        
    }
}

#Preview {
    LoadingView(done: .constant(12.0), total: .constant(100.0))
}
