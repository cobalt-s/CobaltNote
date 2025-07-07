// MARK: EmbeddedToDoListView.swift
import SwiftUI

struct EmbeddedToDoListView: View {
    @Binding var items: [ToDoItem]

    var body: some View {
        List {
            ForEach($items) { $item in
                HStack {
                    // Checkmark Button
                    Button {
                        item.done.toggle()
                    } label: {
                        Image(systemName: item.done ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(item.done ? .green : .secondary)
                    }
                    .buttonStyle(.plain)

                    // Task TextField
                    TextField("New Task", text: $item.text)
                        .strikethrough(item.done)
                }
                .padding(.vertical, 4)
            }
            .onDelete { items.remove(atOffsets: $0) }
            .listRowBackground(Color.white.opacity(0.1))

            // Add Task Button
            Button {
                items.append(ToDoItem(text: "", done: false))
            } label: {
                Label("Add Task", systemImage: "plus")
            }
            .buttonStyle(.plain)
            .listRowBackground(Color.white.opacity(0.1))
        }
        .scrollContentBackground(.hidden) // Makes the List background transparent
        .foregroundColor(.white)
    }
}

