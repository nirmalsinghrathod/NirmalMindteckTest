//
//  BannerView.swift
//  MindteckTest
//
//  Created by Nirmal Singh Rajput on 20/08/24.
//

import SwiftUI

struct BannerView: View {
    
    var place:[String] = ["India","Japan","Indonesia","New Zealand"]
    @State private var isSelectedView = 0
    var showIndecator: Bool = true
    var bannerHeight: CGFloat = 180
    private let screenWidth = UIScreen.main.bounds.size.width
    var bannerChangeAction: ((Int)-> Void)
    
    var body: some View {
        VStack(){
            TabView(selection:$isSelectedView){
                ForEach(place.indices, id: \.self) { index in
                    ZStack(alignment: .bottomLeading, content: {
                        ImageLoadingView(imageURL: place[index])
                        Text(place[index].capitalized)
                            .padding([.bottom,.leading],10)
                            .font(.largeTitle)
                    })
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: bannerHeight)
            
            if showIndecator{
                HStack{
                    ForEach(place.indices, id: \.self) { index in
                        Circle()
                            .frame(height: 6)
                            .foregroundStyle(isSelectedView == index ? .gray.opacity(0.30) : .gray)
                    }
                }
            }
        }
        .onChange(of: isSelectedView) { oldValue, newValue in
            bannerChangeAction(newValue)
        }
    }
}
