// MARK: Note.swift
import UIKit
import PencilKit

struct Note: Identifiable, Hashable {
    let id = UUID()
    var title: String
    let url: URL
    
    // This computed property generates the thumbnail image
    var previewImage: UIImage? {
        guard let data = try? Data(contentsOf: url),
              let drawing = try? PKDrawing(data: data) else {
            return nil
        }
        // Render the thumbnail from the drawing's bounds
        // We add a small inset to avoid cutting off the edges
        let imageRect = drawing.bounds.insetBy(dx: -20, dy: -20)
        return drawing.image(from: imageRect, scale: UIScreen.main.scale)
    }
}
