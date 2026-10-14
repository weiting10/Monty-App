//
//  PhotoViewerView.swift
//  Destinations
//
//  Created by Tan, Weiting on 10/14/26.
//

//
//  PhotoViewerView.swift
//  Destinations
//
//  Screen 5: full-screen photo. Tap anywhere to go back to the diary.
//

import SwiftUI

struct PhotoViewerView: View {

    let image: UIImage

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack {
                Text("Photo Viewer")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(.top, 8)
                Spacer()
                Text("Tap to close")
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(.bottom, 16)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            dismiss()
        }
    }
}

#Preview {
    PhotoViewerView(image: UIImage(systemName: "photo")!)
}
