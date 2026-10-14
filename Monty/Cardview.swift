//
//  Cardview.swift
//  Monty
//
//  Created by Tan, Weiting on 10/14/26.
//

import SwiftUI

struct CardView: View {
    /// Name of the image shown underneath: "ace" or "blank"
    let faceImage: String
    /// When true, the card back is hidden (opacity 0) and the face shows
    let isRevealed: Bool

    var body: some View {
        ZStack {
            // Bottom card (ace or blank)
            Image(faceImage)
                .resizable()
                .scaledToFit()

            // Top card (card back), hidden with opacity when revealed
            Image("cardback")
                .resizable()
                .scaledToFit()
                .opacity(isRevealed ? 0 : 1)
        }
    }
}

#Preview("Face down") {
    CardView(faceImage: "ace", isRevealed: false)
        .padding()
}

#Preview("Revealed") {
    CardView(faceImage: "blank", isRevealed: true)
        .padding()
}
