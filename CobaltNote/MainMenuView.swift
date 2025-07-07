// MARK: MainMenuView.swift
import SwiftUI

struct MainMenuView: View {
    @StateObject private var store = NoteStore()
    @State private var showEditor = false
    @State private var noteToEdit: Note?
    @State private var checklistItems: [ToDoItem] = []
    @State private var showRenameAlert = false
    @State private var renameTarget: Note?
    @State private var newName = ""
    @State private var isAnimatingTitle = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.frutigerBlue, Color.lushGreen]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                
                AnimatedBubblesBackground().ignoresSafeArea().opacity(0.5)
                Circle()
                    .fill(.white.opacity(0.1))
                    .frame(width: 400)
                    .blur(radius: 50)
                    .offset(x: -150, y: -200)

                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        headerView
                        ScrollView {
                            NotesGridView(
                                notes: $store.notes,
                                onOpen: { note in
                                    noteToEdit = note
                                    showEditor = true
                                },
                                onRename: { note in
                                    renameTarget = note
                                    newName = note.title
                                    showRenameAlert = true
                                },
                                onDelete: { store.delete($0) }
                            )
                            
                        }
                    }
                    
                    SidebarView(checklistItems: $checklistItems)
                        .frame(maxWidth: 250)
                        .background(.ultraThinMaterial.opacity(0.95))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding([.vertical, .trailing])
                }
            }
            .foregroundColor(.white)
        }
        .onAppear {
            store.reloadAll()
            // loadChecklistItems()
            isAnimatingTitle = true
        }
        .fullScreenCover(isPresented: $showEditor, onDismiss: {
            store.reloadAll()
        }) {
            NoteEditorView(note: noteToEdit)
                .environmentObject(store)
        }
        .alert("Rename Note", isPresented: $showRenameAlert) {
            TextField("New Name", text: $newName)
            Button("Cancel", role: .cancel) { }
            Button("Rename") {
                if let note = renameTarget {
                    store.rename(note, to: newName)
                    store.reloadAll()
                }
            }
        }
    }
    
    var headerView: some View {
        HStack {
            ZStack {
                Text("CobaltNote")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundStyle(LinearGradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .red], startPoint: .leading, endPoint: .trailing))
                    .hueRotation(.degrees(isAnimatingTitle ? 360 : 0))
                    .blur(radius: 5)
                    .animation(.linear(duration: 5).repeatForever(autoreverses: false), value: isAnimatingTitle)

                Text("CobaltNote")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 3, y: 3)
            }
            Spacer()
            Button(action: {
                noteToEdit = nil
                showEditor = true
            }) { Image(systemName: "plus") }
            .buttonStyle(FrutigerAeroButtonStyle())
        }
        .padding(20)
    }
}




