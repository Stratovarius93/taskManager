//
//  Home.swift
//  Task Manager
//
//  Created by Juan Carlos Catagña Tipantuña on 25/12/22.
//

import SwiftUI
import CoreData

struct Home: View {
    @StateObject var taskModel: TaskViewModel = .init()
    //MARK: Matched Geometry NameSpace
    @Namespace var animation
    
    @Environment(\.self) var env
    
    //MARK: Fetching task
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: false)], predicate: nil, animation: .easeInOut) var tasks: FetchedResults<Task>
    
    var body: some View {
        ScrollView(
            .vertical, showsIndicators: false){
                VStack{
                    VStack(alignment: .leading, spacing: 8){
                        Text("Welcome Back")
                            .font(.callout)
                        Text("Here's Update Today.")
                            .font(.title2.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
                    CustomSegmentedBar()
                        .padding(.top, 5)
                    // MARK: Task View
                    TaskView(taskList: tasks, taskModel: taskModel, env: env)
                }.padding()
                
            }
            .overlay(alignment: .bottom){
                // MARK: Add button
                Button{
                    taskModel.openEditTask.toggle()
                } label: {
                    Label{
                        Text("Add Task").font(.callout).fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "plus.app.fill")
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(.black, in: Capsule())
                }
                //MARK: Linear Gradient BG
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
                .background{
                    LinearGradient(colors: [
                        .white.opacity(0.05),
                        .white.opacity(0.4),
                        .white.opacity(0.7),
                        .white
                    ], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                }
            }
            .fullScreenCover(isPresented: $taskModel.openEditTask){
                taskModel.resetTaskData()
            } content: {AddNewTask().environmentObject(taskModel)}
    }
   
    // MARK: Custom Segmented Bar
    @ViewBuilder
    func CustomSegmentedBar() -> some View {
        // In case if we missed the task
        let tabs = ["Today", "Upcoming", "Task Done", "Failed"]
        HStack(spacing: 10){
            ForEach(tabs, id: \.self){tab in
                Text(tab)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(taskModel.currentTab == tab ? .white : .black)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity)
                    .background{
                        if taskModel.currentTab == tab{
                            Capsule()
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation{
                            taskModel.currentTab = tab
                        }
                    }
            }
        }
    }
    
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()}
//}
