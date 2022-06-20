//
//  TravelToKeelungSwiftUIApp.swift
//  TravelToKeelungSwiftUI
//
//  Created by Br7 on 2022/6/18.
//

import SwiftUI

@main
struct TravelToKeelungSwiftUIApp: App {
    
//    @StateObject private var DataModel = DataServiceViewModel()
    @StateObject private var locationsVM = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(locationsVM)
//                .environmentObject(DataServiceViewModel())
//            ContentView()
        }
    }
}
