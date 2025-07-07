import SwiftUI

// 1) Model
struct ToDoItem: Identifiable, Codable, Equatable{
    var id = UUID()
    var text: String
    var done: Bool
}

// 2) Checklist UI
struct ToDoListView: View {
    @Binding var items: [ToDoItem]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            List {
                ForEach($items) { $item in
                    HStack {
                        Button {
                            item.done.toggle()
                        } label: {
                            Image(systemName: item.done ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(item.done ? .green : .primary)
                        }
                        .buttonStyle(.plain)

                        TextField("Task", text: $item.text)
                            .strikethrough(item.done)
                    }
                }
                .onDelete { offsets in
                    items.remove(atOffsets: offsets)
                }

                Button {
                    items.append(ToDoItem(text: "", done: false))
                } label: {
                    Label("Add Task", systemImage: "plus.circle")
                }
            }
            .navigationTitle("Checklist")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
