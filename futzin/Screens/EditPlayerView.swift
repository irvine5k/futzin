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
    
    @Binding var initialPlayer: Player?
    @State var updatedPlayer: Player = Player(stars: 1, name: "", position: PlayerPosition.offensive)
    var onPlayerUpdated: (Player) -> Void
    
    
    var body: some View {
        VStack {
            TextField("Name", text: $updatedPlayer.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            StarRating(rating: $updatedPlayer.stars)
            
            Picker("Position", selection: $updatedPlayer.position) {
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
        .onAppear {
            updatedPlayer = initialPlayer!
        }
        .navigationBarTitle("Edit Player")
    }
    
    private func savePlayer() {
        onPlayerUpdated(updatedPlayer)
    }
}

