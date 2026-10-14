//
//  ContentView.swift
//  Destinations
//
//  Created by Tan, Weiting on 9/14/26.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(Destinations.self) private var destinations
    @State private var title = "Toronto"
    @State private var firstLine = "Where would you like to go?"
    @State private var image = "toronto_image_3"
    @State private var description = "Toronto is Canada's largest city and one of the most multicultural places in the world. Visitors can go up the CN Tower for skyline views, explore diverse neighborhoods like Kensington Market, and take a short trip to nearby Niagara Falls. The city also has a great food scene, museums, and a lively waterfront."
    @State private var rotation = 360.0
    private var animation: Animation {
    .easeInOut(duration: 1.0)
    .speed(0.1)
    .repeatForever(autoreverses: true)
    }

    
    
    
    var body: some View {
        
        let result = destinations.current()
        
        VStack {
            
            Spacer()
        
            Text(firstLine)
                .font(.system(size: 28))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
              
          
            Spacer()
            
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .clipped()
                .rotation3DEffect(.degrees(rotation),
                axis: (x: 0.0, y: 1.0, z: 0.0))
                .onAppear() {
                    withAnimation(animation) { rotation = 0 }
                }
            
            Spacer()
            
            Text(title)
                .font(.system(size: 34, weight: .bold))
                
            
            Text(description)
                .padding(.horizontal, 30)
             
                
            
            
            Spacer()
            Spacer()
        
            
            
            HStack(spacing: 40) {
                
                Button{
                    destinations.index = (destinations.index - 1) % destinations.destinations.count
                    title = result.destination
                    image = result.image
                    description = result.description
                    firstLine = "Where would you like to go?"
                } label: {
                    Image(systemName: "arrowshape.left.fill")
                        
                }
                
                
                Button("Select"){
                    firstLine = destinations.select()
                   //firstLine = "You have selected \(title)"
                }
                
                
                Button{
                    destinations.index = (destinations.index + 1) % destinations.destinations.count
                    title = result.destination
                    image = result.image
                    description = result.description
                    firstLine = "Where would you like to go?"
                } label: {
                    Image(systemName: "arrowshape.right.fill")
                        
                }
                
                
            }
            .font(.system(size: 26, weight: .semibold))
            .foregroundStyle(Color("arrow_color"))
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
            
        }
        .background(Color("background_color"))
    }
        
}

#Preview {
    ContentView()
        .environment(Destinations())
}
