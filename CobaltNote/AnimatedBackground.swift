//
//  AnimatedBackground.swift
//  CobaltNote
//
//  Created by Cobalt Stamey on 6/29/25.
//

import SwiftUI

struct AnimatedBubblesBackground: View {
    struct Bubble { let id = UUID(); let size: CGFloat; let xPos: CGFloat; let speed: Double; let delay: Double }
    private static let bubbles: [Bubble] = (0..<30).map { _ in
        Bubble(
            size: CGFloat.random(in: 40...120),
            xPos: CGFloat.random(in: 0...1),
            speed: Double.random(in: 15...40),
            delay: Double.random(in: 0...20)
        )
    }
    var body: some View {
        TimelineView(.animation) { timeline in
            let t = timeline.date.timeIntervalSinceReferenceDate
            Canvas { context, size in
                for bubble in Self.bubbles {
                    let progress = ((t + bubble.delay).truncatingRemainder(dividingBy: bubble.speed)) / bubble.speed
                    let y = size.height + bubble.size/2 - progress * (size.height + bubble.size)
                    let x = bubble.xPos * size.width
                    context.fill(
                        Path(ellipseIn: CGRect(x: x, y: y, width: bubble.size, height: bubble.size)),
                        with: .color(Color.white.opacity(0.1))
                    )
                }
            }
            .drawingGroup()
        }
    }
}
