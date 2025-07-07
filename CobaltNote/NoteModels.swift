// MARK: NoteModels.swift
import SwiftUI
import PencilKit

// Represents a single text box on the page
struct TextBox: Identifiable, Equatable {
    let id = UUID()
    var text: String = "Tap to edit"
    var position: CGPoint
    var size: CGSize = CGSize(width: 250, height: 150)
    var isSelected: Bool = false
}

// Represents a single page in a note
struct Page: Identifiable, Equatable {
    let id = UUID()
    var drawing: PKDrawing = PKDrawing()
    var textBoxes: [TextBox] = []
}
