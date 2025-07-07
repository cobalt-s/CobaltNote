import SwiftUI

struct CausticsView: View {
    @State private var animate = false

    var body: some View {
        GeometryReader { geo in
            Image("caustics")
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width * 1.5, height: geo.size.height * 1.5)
                .opacity(0.2)
                .blendMode(.overlay) 
                .blur(radius: 4)
                .offset(x: animate ? -80 : 80, y: animate ? -80 : 80)
                .onAppear {
                    withAnimation(.linear(duration: 40).repeatForever(autoreverses: true)) {
                        animate = true
                    }
                }
        }
        .ignoresSafeArea()
    }
}
