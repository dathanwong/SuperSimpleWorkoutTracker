//
//  MuscleView.swift
//  SuperSimpleWorkoutTracker
//
//  Created by Dathan Wong on 6/25/20.
//  Copyright © 2020 Dathan Wong. All rights reserved.
//

import SwiftUI

struct MuscleView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var newExercise = ""
    var fetchRequest: FetchRequest<MuscleGroup>
    private var muscleGroup: MuscleGroup{
        fetchRequest.wrappedValue.first!
    }
    
    init(filter: String){
        fetchRequest = FetchRequest<MuscleGroup>(entity: MuscleGroup.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name == %@", filter))
    }
    
    var body: some View {
        VStack{
            List{
                ForEach(muscleGroup.exerciseArray, id: \.self){ exercise in
                    ExerciseView(exercise: exercise)
                }
            }
            HStack{
                TextField("Add an exercise", text: self.$newExercise)
                Button(action: {
                    let e = Exercise(context: self.moc)
                    e.name = self.newExercise
                    e.weight = 0
                    e.reps = 0
                    e.muscleGroup = self.muscleGroup
                    try? self.moc.save()
                }) {
                    Text("Add")
                }
            }.padding()
            
        }
    }
}

struct ExerciseView: View{
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var exercise: Exercise
    
    var body: some View{
        HStack{
            Text("\(exercise.wrappedName)")
                .font(.body)
            Spacer()
            Spacer()
            Button(action: {
                //Decrease reps
                if(self.exercise.reps > 0){
                    self.exercise.reps -= 1
                    try? self.moc.save()
                }
            }) {
                Image(systemName: "minus.square.fill")
                    .foregroundColor(.gray)
                    .font(.title)
            }.buttonStyle(BorderlessButtonStyle())
            Text("\(self.exercise.reps)")
                .font(.title)
            Button(action: {
                //Increase reps
                self.exercise.reps += 1
                try? self.moc.save()
            }) {
                Image(systemName: "plus.square.fill")
                    .foregroundColor(.blue)
                    .font(.title)
            }.buttonStyle(BorderlessButtonStyle())
            Spacer()
            Button(action: {
                //Decrease weight
                if(self.exercise.weight > 4){
                    self.exercise.weight -= 5
                    try? self.moc.save()
                }else{
                    self.exercise.weight = 0
                    try? self.moc.save()
                }
            }) {
                Image(systemName: "minus.square.fill")
                    .foregroundColor(.gray)
                    .font(.title)
            }.buttonStyle(BorderlessButtonStyle())
            Text("\(self.exercise.weight)")
                .font(.title)
            Button(action: {
                //Increase weight
                self.exercise.weight += 5
                try? self.moc.save()
            }) {
                Image(systemName: "plus.square.fill")
                    .foregroundColor(.blue)
                    .font(.title)
            }.buttonStyle(BorderlessButtonStyle())
        }.padding()
    }
}

struct MuscleView_Previews: PreviewProvider {
    
    static var previews: some View {
        MuscleView(filter: "Back")
    }
}
