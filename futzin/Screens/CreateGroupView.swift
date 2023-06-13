//
//  CreateGroupView.swift
//  futzin
//
//  Created by Kelven Galvao on 11/06/23.
//

import SwiftUI
import CoreData

struct CreateGroupView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var name = ""
    @State private var playerCountPerTeam: Double = 0
    var onGroupCreated: () -> Void
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Slider(value: $playerCountPerTeam, in: 1...5, step: 1)
            
            Button(action: createGroup) {
                Text("Create Group")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

extension CreateGroupView {
    func createGroup() {
        withAnimation {
            let newGroup = GroupModel(context: viewContext)
            newGroup.name = name
            newGroup.playersCountPerTeam = Int16(playerCountPerTeam)
            newGroup.players = []
            
            do {
                try viewContext.save()
            
                // Clear the input fields after successful creation
                name = ""
                
                onGroupCreated()
            } catch {
                print("Failed to create group: \(error)")
            }
        }
    }
}
