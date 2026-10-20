import SwiftUI

/// A card that flips around the Y axis. The angle is animatable, so the
/// image swaps from back to face exactly when the card is edge-on (90°).
struct FlipCard: View, Animatable {
    var angle: Double          // 0 = back showing, 180 = face showing
    let faceImage: String

    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }

    var body: some View {
        ZStack {
            if angle < 90 {
                Image("cardback")
                    .resizable()
                    .scaledToFit()
            } else {
                Image(faceImage)
                    .resizable()
                    .scaledToFit()
                    // counter-rotate so the face isn't mirrored
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
        }
        .rotation3DEffect(.degrees(angle), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardView: View {
    /// Name of the face image: "ace" or "blank"
    let faceImage: String
    /// true = face up, false = back showing
    let isRevealed: Bool

    var body: some View {
        FlipCard(angle: isRevealed ? 180 : 0, faceImage: faceImage)
    }
}

#Preview("Face down") {
    CardView(faceImage: "ace", isRevealed: false)
        .padding()
}

#Preview("Revealed") {
    CardView(faceImage: "ace", isRevealed: true)
        .padding()
}
