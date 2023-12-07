//
//  ContentView.swift
//  SwiftMC_AsyncImage
//
//  Created by Jay Jahanzad on 2023-12-06.
//

import SwiftUI

extension Image {
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifier() -> some View {
        self
        // Notice using imageModifier() here
            .imageModifier()
            .frame(maxWidth: 120)
            .foregroundColor(.blue)
            .opacity(0.5)
    }
}

struct ContentView: View {
    private let imageURL: String = "https://credo.academy/credo-academy@3x.png"
    var body: some View {
        // MARK: 1. BASIC
        
        //        AsyncImage(url: URL(string: imageURL))
        
        // MARK: 2. SCALE
        
        //        AsyncImage(url: URL(string: imageURL), scale: 3.0)
        
        // MARK: 3. PLACEHOLDER
        
        /*
         AsyncImage(url: URL(string: imageURL)) { image in
         image
         .imageModifier()
         } placeholder: {
         Image(systemName: "photo.circle.fill")
         .iconModifier()
         }
         .padding(40)
         */
        
        // MARK: 4. PHASE
        
        /*
         AsyncImage(url: URL(string: imageURL)){ phase in
         // SUCCESS: The image successfully loaded
         
         // FAILURE: Image failed to load with error
         
         // EMPTY: No image is loaded
         
         if let image = phase.image {
         image.imageModifier()
         } else if phase.error != nil {
         Image(systemName: "ant.circle.fill").iconModifier()
         } else {
         Image(systemName: "photo.circle.fill").iconModifier()
         }
         }
         .padding(40)
         */
        
        // MARK: 5. ANIMATION
        
        // JJ Note: the AsyncImage phase is actually an enumeration that keeps track of current phase in the download operation, so you can actually keep track of the phases
        
        AsyncImage(url: URL(string: imageURL), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
            switch phase {
            case .success(let image):
                image
                    .imageModifier()
//                    .transition(.move(edge: .bottom))
//                    .transition(.slide)
                    .transition(.scale)
            case .failure(_):
                Image(systemName: "ant.circle.fill").iconModifier()
            case .empty:
                Image(systemName: "photo.circle.fill").iconModifier()
            @unknown default:
                ProgressView()
            }
        }
        .padding(40)
    }
}

#Preview {
    ContentView()
}
