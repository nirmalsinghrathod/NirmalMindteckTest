//
//  ImageLoadingView.swift
//  MindteckTest
//
//  Created by Nirmal Singh Rajput on 20/08/24.
//

import SwiftUI

struct ImageLoadingView: View {
    
    var imageURL = String()
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in // 1
            if let image = phase.image { // 2
                // if the image is valid
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil { // 3
                // some kind of error appears
                if UIImage(named: imageURL) == nil {
                    ProgressView()
                }else{
                    Image(imageURL)
                        .resizable()
                        .scaledToFit()
                }
            } else { // 4
                // showing progress view as placeholder
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(.gray.opacity(0.3))
    }
}

#Preview {
    ImageLoadingView()
}
