//
//  CreatePlayer.swift
//  futzin
//
//  Created by Kelven Galvao on 09/06/23.
//

import SwiftUI
import CoreData

struct PlayerCreatorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var group: GroupModel
    @State private var name = ""
    @State private var stars = 0
    @State private var position = PlayerPosition.defensive
    var onPlayerCreated: () -> Void
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            StarRating(rating: $stars)
            
            Picker("Position", selection: $position) {
                Text("Defensive").tag(PlayerPosition.defensive)
                Text("Offensive").tag(PlayerPosition.offensive)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Button(action: createPlayer) {
                Text("Create Player")
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

extension PlayerCreatorView {
    func createPlayer() {
        withAnimation {
            let newPlayer = PlayerModel(context: viewContext)
            newPlayer.stars = Int16(stars)
            newPlayer.name = name
            newPlayer.position = position.rawValue
            group.addToPlayers(newPlayer)
            
            do {
                try viewContext.save()
                print("Player Created: \(newPlayer)")
                
                // Clear the input fields after successful creation
                name = ""
                stars = 0
                position = .defensive
                
                onPlayerCreated()
            } catch {
                print("Failed to create player: \(error)")
            }
        }
    }
}
