//
//  EditPlayer.swift
//  futzin
//
//  Created by Kelven Galvao on 09/06/23.
//

import SwiftUI

import SwiftUI

struct EditPlayerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var player: Player
    @Binding var isUpdatingUser: Bool
    
    var body: some View {
        VStack {
            TextField("Name", text: $player.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            StarRating(rating: $player.stars)
            
            Picker("Position", selection: $player.position) {
                Text("Defensive").tag(PlayerPosition.defensive)
                Text("Offensive").tag(PlayerPosition.offensive)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Button(action: savePlayer) {
                Text("Update Player")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Edit Player")
    }
    
    private func savePlayer() {
        do {
            try viewContext.save()
            isUpdatingUser = false
        } catch {
            // Handle the error
        }
    }
}

