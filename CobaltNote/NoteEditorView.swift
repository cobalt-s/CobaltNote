// MARK: NoteEditorView.swift
import SwiftUI
import PencilKit

struct NoteEditorView: View {
    @EnvironmentObject var store: NoteStore
    @Environment(\.dismiss) var dismiss

    // State
    @State private var drawing: PKDrawing
    private var noteToEdit: Note?
    @State private var filename: String
    
    // State for the canvas and Apple's tool picker
    @State private var canvas = PKCanvasView()
    @State private var toolPicker = PKToolPicker()

    init(note: Note?) {
        self.noteToEdit = note
        
        if let existingNote = note, let data = try? Data(contentsOf: existingNote.url) {
            self._drawing = State(initialValue: (try? PKDrawing(data: data)) ?? PKDrawing())
            self._filename = State(initialValue: existingNote.title)
        } else {
            self._drawing = State(initialValue: PKDrawing())
            self._filename = State(initialValue: "Untitled Note")
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            // FIX: CanvasView is now called with the correct parameters
            CanvasView(canvas: $canvas, drawing: $drawing)
                .background(Color.white)
                .ignoresSafeArea()
                .onAppear(perform: setupToolPicker) // Show the tool picker

            topToolbar
        }
    }
    
    var topToolbar: some View {
        HStack(spacing: 15) {
            Button { dismiss() } label: { Image(systemName: "chevron.down") }
                .buttonStyle(FrutigerAeroButtonStyle(color: .gray))

            TextField("Filename", text: $filename)
                .font(.headline)
                .padding()
                .background(.white.opacity(0.9))
                .clipShape(Capsule())
                .shadow(color: .black.opacity(0.2), radius: 3, y: 2)

            Spacer()
            
            Button("Save") {
                store.save(drawing: drawing, withName: filename)
                if let originalNote = noteToEdit, originalNote.title != filename {
                    store.rename(originalNote, to: filename)
                }
                dismiss()
            }
            .buttonStyle(FrutigerAeroButtonStyle(color: .lushGreen))
        }
        .padding()
    }
    
    // This function sets up and shows Apple's native tool picker
    private func setupToolPicker() {
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.becomeFirstResponder()
    }
}
