// MARK: WaterEffect.swift

//doesn't fully work, need to mess around more with metal. 
import SwiftUI

struct UnderwaterEffect: ViewModifier {
    func body(content: Content) -> some View {
        TimelineView(.animation) { context in
            content
                // drawingGroup() is essential for distortion effects to work.
                .drawingGroup()
                .distortionEffect(
                    ShaderLibrary.waterEffect(
                        // Pass the current time to the shader to drive the animation
                        .float(context.date.timeIntervalSince1970)
                    ),
                    maxSampleOffset: .zero
                )
        }
    }
}

extension View {
    func underwater() -> some View {
        self.modifier(UnderwaterEffect())
    }
}
