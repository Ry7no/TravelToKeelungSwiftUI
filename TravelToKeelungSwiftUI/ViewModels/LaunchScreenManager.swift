//
//  LaunchScreenManager.swift
//  TravelToKeelungSwiftUI
//
//  Created by Br7 on 2022/7/2.
//

import Foundation

enum LaunchScreenPhase {
    case first
    case second
    case completed
}

final class LaunchScreenManager: ObservableObject {
    
    @Published private(set) var state: LaunchScreenPhase = .first
    
    func dismiss(){
        
        self.state = .second
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.state = .completed
        }
    }  
}

