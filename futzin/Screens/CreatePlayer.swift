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
    
    func createPlayer() {
        withAnimation {
            let newPlayer = PlayerModel(context: viewContext)
            newPlayer.stars = Int16(stars)
            newPlayer.name = name
            newPlayer.position = position.rawValue
            
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

struct StarRating: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
    }
}
