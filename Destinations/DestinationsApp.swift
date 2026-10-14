//
//  DestinationsApp.swift
//  Destinations
//
//  Created by Tan, Weiting on 9/14/26.
//

import SwiftUI

@main
struct DestinationsApp: App {
    
    let destinations = Destinations()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(destinations)
        }
    }
}
