// MARK: NoteStore.swift
import SwiftUI
import PencilKit

class NoteStore: ObservableObject {
    @Published var notes: [Note] = []
    private let docsURL: URL

    init() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Could not find documents directory.")
        }
        self.docsURL = url
        reloadAll()
    }

    func reloadAll() {
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: docsURL, includingPropertiesForKeys: nil)
            self.notes = fileURLs.filter { $0.pathExtension == "cnote" }.map { url in
                Note(title: url.deletingPathExtension().lastPathComponent, url: url)
            }
            .sorted(by: { $0.title < $1.title }) // Sort notes alphabetically
        } catch {
            print("Error loading notes: \(error)")
        }
    }

    func save(drawing: PKDrawing, withName name: String) {
        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanName.isEmpty else { return }
        let fileURL = docsURL.appendingPathComponent(cleanName).appendingPathExtension("cnote")
        let data = drawing.dataRepresentation()
        try? data.write(to: fileURL)
    }
    
    func rename(_ note: Note, to newTitle: String) {
        let cleanNewTitle = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanNewTitle.isEmpty else { return }
        let newURL = docsURL.appendingPathComponent(cleanNewTitle).appendingPathExtension("cnote")
        try? FileManager.default.moveItem(at: note.url, to: newURL)
    }

    func delete(_ note: Note) {
        try? FileManager.default.removeItem(at: note.url)
        reloadAll()
    }
}
