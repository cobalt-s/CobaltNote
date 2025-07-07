// MARK: SidebarView.swift
import SwiftUI

struct SidebarView: View {
    @Binding var checklistItems: [ToDoItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("To-Do List")
                .font(.title2.bold())
                .padding(.horizontal)
            
            // The embedded list is now directly visible
            EmbeddedToDoListView(items: $checklistItems)
            
            Divider().padding(.vertical)
            
            Text("Templates")
                .font(.title2.bold())
                .padding(.horizontal)
            Text("Templates will go here...if I work on this more lol").padding(.horizontal)
            
            Spacer()
        }
        .padding(.vertical, 20)
    }
}
