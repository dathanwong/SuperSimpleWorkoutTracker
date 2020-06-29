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
    var filter: String
    
    init(filter: String){
        self.filter = filter
        fetchRequest = FetchRequest<MuscleGroup>(entity: MuscleGroup.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name == %@", filter))
    }
    
    var body: some View {
        VStack{
            List{
                ForEach(fetchRequest.wrappedValue, id: \.self){ mg in
                    ForEach(mg.exerciseArray, id:\.self){ exercise in
                        ExerciseView(exercise: exercise)
                    }
                }
                //.onDelete(perform: deleteExercise)
            }
            HStack{
                TextField("Add an exercise", text: self.$newExercise)
                Button(action: {
                    let e = Exercise(context: self.moc)
                    e.name = self.newExercise
                    e.weight = 0
                    e.reps = 0
                    let muscleGroup = MuscleGroup(context: self.moc)
                    muscleGroup.name = self.filter
                    e.muscleGroup = muscleGroup
                    try? self.moc.save()
                }) {
                    Text("Add")
                }
            }.padding()
            
        }
    }
    
//    func deleteExercise(at offsets: IndexSet) {
//        for index in offsets{
//            let exercise = muscleGroup.exerciseArray[index]
//            moc.delete(exercise)
//            try? moc.save()
//        }
//    }
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
