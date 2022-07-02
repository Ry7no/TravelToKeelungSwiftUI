//
//  TravelToKeelungSwiftUIApp.swift
//  TravelToKeelungSwiftUI
//
//  Created by Br7 on 2022/6/18.
//

import SwiftUI

@main
struct TravelToKeelungSwiftUIApp: App {

    @StateObject private var locationsVM = LocationsViewModel()
    @StateObject var launchScreenManager = LaunchScreenManager()
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                
                LocationsView()
                    .environmentObject(locationsVM)
                
                if launchScreenManager.state != .completed {
                    LaunchScreenView()
                }
            }
            .environmentObject(launchScreenManager)
        }
    }
}
