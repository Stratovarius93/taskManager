//
//  TaskViewModel.swift
//  Task Manager
//
//  Created by Juan Carlos Catagña Tipantuña on 25/12/22.
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
    @Published var currentTab: String = "Today"
    
    //MARK: New Task Properties
    @Published var openEditTask: Bool = false
    @Published var taskTitle: String = ""
    @Published var taskColor: String = "Yellow"
    @Published var taskDeadLine: Date = Date()
    @Published var taskType: String = "Basic"
    @Published var showDatePicker: Bool = false
    
    //MARK: Editing existing task data
    @Published var editTask: Task?
    
    // MARK: Adding task to CoreData
    func addTask(context: NSManagedObjectContext) ->Bool {
        //MARK: Updating existing data in CoreData
        var task: Task!
        if let editTask = editTask{
            task = editTask
        }else{
            task = Task(context: context)
        }
        task.title = taskTitle
        task.color = taskColor
        task.deadline = taskDeadLine
        task.type = taskType
        task.isCompleted = false
        
        if let _ = try? context.save(){
            return true
        }
        return false
    }
    
    // MARK: Resetting data
    func resetTaskData(){
        taskType = "Basic"
        taskColor = "Yellow"
        taskTitle = ""
        taskDeadLine = Date()
        editTask = nil
    }
        
    // MARK: If edit task is available then setting existing data
    func setupTask(){
        if let editTask = editTask{
            taskType = editTask.type ?? "Basic"
            taskColor = editTask.color ?? "Yellow"
            taskTitle = editTask.title ?? ""
            taskDeadLine = editTask.deadline ?? Date()
        }
    }
}
