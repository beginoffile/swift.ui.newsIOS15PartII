//
//  RelojUIView.swift
//  NewsIOS15PartII
//
//  Created by Aguid Ramirez Sanchez on 03/03/24.
//

import SwiftUI

struct RelojUIView: View {
    
    let color: [Color] = [.red, .green, .blue, .purple, .yellow, .pink]
    let emoji = ["🐶","🐱","🐰","🦊","🐸","🐤"]
    
    var body: some View {
        TimelineView(PeriodicTimelineSchedule(from: Date(), by: 1)) { _ in
            let date = Date.now
            let time = date.formatted(.dateTime.hour().minute().second())
            let day = date.formatted(.dateTime.day(.defaultDigits))
            let dayName = date.formatted(.dateTime.weekday(.wide))
            Text("\(day) \(Text(dayName))")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text(time)
                .font(.largeTitle)
                .foregroundColor(color.randomElement())
            Text(emoji.randomElement() ?? "")
                .scaleEffect(2)
        }
    }
}

#Preview {
    RelojUIView()
}
