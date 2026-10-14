//
//  HomeView.swift
//  Destinations
//
//  Created by Tan, Weiting on 10/5/26.
//

import SwiftUI

struct HomeView: View {
    @Environment(Destinations.self) private var destinations
    @State private var showDestination = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                Image(systemName: "airplane.departure")
                    .font(.system(size: 70))
                    .foregroundStyle(Color("arrow_color"))

                Text("Ready for your next adventure?")
                    .font(.system(size: 28))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Spacer()

                NavigationLink {
                    VisitedPlacesView()
                } label: {
                    Text("Places I've been")
                        .font(.title2.bold())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color("arrow_color"))

                Button {
                    destinations.randomize()
                    showDestination = true
                } label: {
                    Text("Get your next destination")
                        .font(.title3.bold())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 6)
                }
                .buttonStyle(.bordered)
                .tint(Color("arrow_color"))
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("background_color").ignoresSafeArea())
            .navigationDestination(isPresented: $showDestination) {
                DestinationView()
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(Destinations())
        .environment(VisitedStore())
}
