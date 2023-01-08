//
//  TaskView.swift
//  Task Manager
//
//  Created by Juan Carlos Catagña Tipantuña on 7/1/23.
//

import SwiftUI
import CoreData

struct TaskView<Results: RandomAccessCollection>: View where Results.Element == Task {
    let taskList: Results
    var taskModel: TaskViewModel
    var env: EnvironmentValues
    var body: some View {
        LazyVStack(spacing: 20){
//             MARL: Custom filtered request view
//                        ForEach(taskList){task in TaskRowView(task: task)}
            DynamicFilteredView(currentTab: taskModel.currentTab){(task: Task) in TaskRowView(task: task)}
        }.padding(.top, 20)
    }
    // MARK: Task Row view
    @ViewBuilder
    func TaskRowView(task: Task) -> some View {
        VStack(alignment: .leading, spacing: 10){
            HStack{
                Text(task.type ?? "")
                    .font(.callout)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background{
                        Capsule()
                            .fill(.gray.opacity(0.3))
                    }
                Spacer()
                // MARK: Edit button only for non completed task
                if !task.isCompleted && taskModel.currentTab != "Failed"{
                    Button{
                        taskModel.editTask = task
                        taskModel.openEditTask = true
                        taskModel.setupTask()
                    }
                label: {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(.black)
                }
                }
            }
            Text(task.title ?? "")
                .font(.title2.bold())
                .foregroundColor(.black)
                .padding(.vertical, 10)
            HStack(alignment: .bottom, spacing: 0){
                VStack(alignment: .leading, spacing: 10){
                    Label{
                        Text((task.deadline ?? Date()).formatted(date: .long, time: .omitted))
                    }icon: {
                        Image(systemName: "calendar")
                    }
                    Label{
                        Text((task.deadline ?? Date()).formatted(date: .omitted, time: .shortened))
                    } icon: {
                        Image(systemName: "clock")
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                if !task.isCompleted && taskModel.currentTab != "Failed"{
                    Button{
                        //MARK: Updating coreData
                        task.isCompleted.toggle()
                        try? env.managedObjectContext.save()
                    } label: {
                        Circle()
                            .strokeBorder(.black, lineWidth: 1.5)
                            .frame(width: 25, height: 25)
                            .contentShape(Circle())
                    }
                }
            }
        }.padding()
            .frame(maxWidth: .infinity)
            .background{
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(task.color ?? "Yellow"))
            }
    }
    
}

struct TaskView_Previews: PreviewProvider {
    static let taskEntity = NSManagedObjectModel.mergedModel(from: nil)?.entitiesByName["Task"]
    static var previews: some View {
    @Environment(\.self) var env
    @StateObject var taskModel: TaskViewModel = .init()
        let task = Task(entity: taskEntity!, insertInto: nil )
        task.title = "Test1"
        task.deadline = Date()
        task.isCompleted = false
        task.color = "Yellow"
        task.type = "Basic"
        return TaskView(taskList: [task], taskModel: taskModel, env: env)
    }
}
   
