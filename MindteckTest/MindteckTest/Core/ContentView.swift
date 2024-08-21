//
//  ContentView.swift
//  MindteckTest
//
//  Created by Nirmal Singh Rajput on 20/08/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                Text("")
                    .frame(maxWidth: .infinity)
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
                        // Banner
                        BannerView(place:viewModel.bannerList) { value in
                            viewModel.getPlaceList(from: viewModel.bannerList[value])
                            viewModel.searchValue = ""
                        }
                        
                        //MARK: Place List View
                        Section {
                            if viewModel.iserror {
                                errorView
                            }else{
                                let query = viewModel.searchValue.trimmingCharacters(in: .whitespaces)
                                
                                if !query.isEmpty {
                                    if viewModel.searchPlaceList.count == 0{
                                        errorView
                                    }else{
                                        ForEach(viewModel.searchPlaceList, id: \.name) { place in
                                            PlaceDetailView(placeData: place)
                                                .padding(15)
                                                .transition(AnyTransition.scale)
                                        }
                                    }
                                }else{
                                    ForEach(viewModel.placeList, id: \.name) { place in
                                        withAnimation(.easeInOut){
                                            PlaceDetailView(placeData: place)
                                                .padding(15)
                                                .transition(AnyTransition.scale)
                                        }
                                    }
                                }
                            }
                        } header: {
                            searchBar
                        }
                    }
                }
            }
            if viewModel.isloading{
                LoadingView()
            }
        }
        .task {
            if let place = viewModel.bannerList.first{
                viewModel.getPlaceList(from: place)
            }
        }
    }
    
    //MARK: Search Bar View
    private var searchBar: some View{
        ZStack{
            HStack(spacing:5){
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $viewModel.searchValue)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .onChange(of: viewModel.searchValue) {
                        let query = viewModel.searchValue
                        viewModel.searchPlaceList = viewModel.placeList.filter{ $0.name.lowercased()
                            .contains(query.lowercased()) }
                    }
                    .keyboardType(.asciiCapable)
                    .autocorrectionDisabled()
            }
            .foregroundStyle(.gray)
            .padding(.leading,10)
            .background{
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(.gray.opacity(0.2))
            }
            .padding(20)
        }
        .background(.white)
    }
    
    //MARK: Error View
    private var errorView: some View {
        HStack(alignment:.center){
            Image(systemName: "exclamationmark.warninglight.fill")
                .frame(width: 30,height: 30)
            Text("No Data Found!")
                .font(.largeTitle)
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(.red)
        .padding(.vertical,120)
    }
}

#Preview {
    ContentView()
}

