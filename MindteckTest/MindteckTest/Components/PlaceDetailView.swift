//
//  PlaceDetailView.swift
//  MindteckTest
//
//  Created by Nirmal Singh Rajput on 20/08/24.
//

import SwiftUI

struct PlaceDetailView: View {
    var placeData: PlaceData
    
    var body: some View {
        HStack{
            ImageLoadingView(imageURL: placeData.image)
                .clipShape(Circle())
                .frame(width: 60,height: 60)
            
            VStack(alignment:.leading){
                Text("Name:- \(placeData.name)")
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
        }
    }
}
