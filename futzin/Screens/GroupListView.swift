//
//  GroupView.swift
//  futzin
//
//  Created by Kelven Galvao on 11/06/23.
//

import SwiftUI

struct GroupListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var groups: FetchedResults<GroupModel>
    @State private var isCreatingGroup = false

    var body: some View {
        List {
            ForEach(groups, id: \.self) { group in
                NavigationLink(
                    value: Route.group(group: group),
                    label: {
                        Text(group.name ?? "")
                })
            }
            .onDelete { indexSet in
                deleteGroups(at: indexSet)
            }
            .contentShape(Rectangle())
            
        }
        .navigationTitle("Groups")
        .toolbar {
            Button("Create Group") {
                isCreatingGroup = true
            }
        }
        .sheet(isPresented: $isCreatingGroup, content: {
            CreateGroupView(onGroupCreated: {
                isCreatingGroup = false
            })
        })
    }
    
    private func deleteGroups(at offsets: IndexSet) {
        for index in offsets {
            let group = groups[index]
            viewContext.delete(group)
        }

        do {
            try viewContext.save()
        } catch {
            // Handle error
        }
    }
}


struct GroupListView_Previews: PreviewProvider {
    static var previews: some View {
        GroupListView()
    }
}
