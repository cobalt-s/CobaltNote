// MARK: NotesGridView.swift
import SwiftUI

struct NotesGridView: View {
    @Binding var notes: [Note]
    var onOpen: (Note) -> Void
    var onRename: (Note) -> Void
    var onDelete: (Note) -> Void

    private let columns = [
        GridItem(.adaptive(minimum: 160), spacing: 35)
    ]

    var body: some View {
        // The ScrollView has been removed from this view.
        LazyVGrid(columns: columns, spacing: 40) {
            ForEach(notes) { note in
                NoteCell(note: note)
                    .onTapGesture { onOpen(note) }
                    .contextMenu {
                        Button("Rename") { onRename(note) }
                        Button("Delete", role: .destructive) { onDelete(note) }
                    }
            }
        }
        .padding(15)
    }
}


// Redesigned NoteCell with a glossy title bar
struct NoteCell: View {
    let note: Note

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if let image = note.previewImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    LinearGradient(colors: [.gray.opacity(0.1), .gray.opacity(0.3)], startPoint: .top, endPoint: .bottom)
                    Image(systemName: "drop.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.white.opacity(0.3))
                }
            }
            .frame(height: 160)
            .frame(width: 100)
            .clipped()

            // Glossy title bar
            Text(note.title)
                .font(.headline)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.5), radius: 2)
                .lineLimit(1)
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(colors: [Color.frutigerBlue.opacity(0.7), Color.frutigerBlue.opacity(0.9)], startPoint: .top, endPoint: .bottom)
                        .overlay(.black.opacity(0.2))
                )
        }
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.white.opacity(0.4), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.3), radius: 8, y: 4)
    }
}
