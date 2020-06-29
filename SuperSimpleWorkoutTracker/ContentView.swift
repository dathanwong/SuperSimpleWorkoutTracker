//
//  ContentView.swift
//  SuperSimpleWorkoutTracker
//
//  Created by Dathan Wong on 6/25/20.
//  Copyright © 2020 Dathan Wong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        UITabBarWrapper([
            TabBarElement(tabBarElementItem: .init(title: "Back"), {
                MuscleView(filter: "Back")
            }),
            TabBarElement(tabBarElementItem: .init(title: "Chest"), {
                MuscleView(filter: "Chest")
            }),
            TabBarElement(tabBarElementItem: .init(title: "Biceps"), {
                MuscleView(filter: "Biceps")
            }),
            TabBarElement(tabBarElementItem: .init(title: "Shoulder"), {
                MuscleView(filter: "Shoulder")
            }),
            TabBarElement(tabBarElementItem: .init(title: "Tricep"), {
                MuscleView(filter: "Tricep")
            }),
            TabBarElement(tabBarElementItem: .init(title: "Legs"), {
                MuscleView(filter: "Legs")
            }),
            TabBarElement(tabBarElementItem: .init(title: "Abs"), {
                MuscleView(filter: "Abs")
            })
        ])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
