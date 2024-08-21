//
//  ViewModel.swift
//  MindteckTest
//
//  Created by Nirmal Singh Rajput on 20/08/24.
//

import Foundation

class ContentViewModel: ObservableObject{
    
    @Published var searchValue: String = ""
    @Published var isloading: Bool = false
    @Published var iserror: Bool = false
    @Published var placeList: [PlaceData] = []
    @Published var searchPlaceList: [PlaceData] = []
    let bannerList: [String] = ["India","Japan","Indonesia","New Zealand","Australia"]
    
    func getPlaceList(from:String) {
        
        if let fileLocation = Bundle.main.url(forResource: from, withExtension: "json") {
            isloading = true
            iserror = false
            // do catch in case of error
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([PlaceData].self, from: data)
                placeList = dataFromJson
                isloading = false
            } catch {
                print(error)
                iserror = true
                isloading = false
            }
        }else{
            iserror = true
        }
    }
}
