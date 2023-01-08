//
//  ContentView.swift
//  Task Manager
//
//  Created by Juan Carlos Catagña Tipantuña on 25/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            Home().navigationBarTitle("Task Manager")
                .navigationBarTitleDisplayMode(.inline)
            
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
