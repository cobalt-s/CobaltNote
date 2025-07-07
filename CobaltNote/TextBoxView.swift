// MARK: TextBoxView.swift
import SwiftUI

struct TextBoxView: View {
    @Binding var box: TextBox
    @FocusState private var isFocused: Bool

    var body: some View {
        TextEditor(text: $box.text)
            .focused($isFocused)
            .font(.system(size: 24))
            .padding(10)
            .frame(width: box.size.width, height: box.size.height)
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isFocused ? Color.blue : Color.white.opacity(0.4), lineWidth: 2)
            )
            .position(box.position)
            .gesture(
                DragGesture().onChanged { value in
                    box.position = value.location
                }
            )
            .onTapGesture {
                isFocused = true
            }
    }
}
