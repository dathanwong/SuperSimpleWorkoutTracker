//
//  ContentView.swift
//  SuperSimpleWorkoutTracker
//
//  Created by Dathan Wong on 6/25/20.
//  Copyright © 2020 Dathan Wong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    init() {
        //Create muscle group entities if first time launching
        if(!isAppAlreadyLaunchedOnce()){
            let back = MuscleGroup(context: moc)
            back.name = "Back"
            let chest = MuscleGroup(context: moc)
            chest.name = "Chest"
            let legs = MuscleGroup(context: moc)
            legs.name = "Legs"
            let shoulder = MuscleGroup(context: moc)
            shoulder.name = "Shoulder"
            let bicep = MuscleGroup(context: moc)
            bicep.name = "Biceps"
            let tricep = MuscleGroup(context: moc)
            tricep.name = "Tricep"
            let abs = MuscleGroup(context: moc)
            abs.name = "Abs"
            try? moc.save()
            print("Muscle groups created on first launch")
        }
    }
    
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
    
    //Check if app is launched for the first time and generate Muscle Groups
    func isAppAlreadyLaunchedOnce() -> Bool {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce") {
            print("App already launched")
            return true
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
