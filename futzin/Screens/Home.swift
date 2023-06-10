//
//  Home.swift
//  futzin
//
//  Created by Kelven Galvao on 09/06/23.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isCreatingPlayer = false
    
    var body: some View {
        NavigationView {
            VStack {
                PlayerListView()
                
                Button(action: {
                    isCreatingPlayer = true
                }, label: {
                    Text("Create New Player")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                .sheet(isPresented: $isCreatingPlayer, content: {
                    PlayerCreatorView(onPlayerCreated: {
                        isCreatingPlayer = false
                    })
                })
                .padding()
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

