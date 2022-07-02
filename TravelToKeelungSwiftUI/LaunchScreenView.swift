//
//  LaunchScreenView.swift
//  TravelToKeelungSwiftUI
//
//  Created by Br7 on 2022/7/2.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    @State private var firstPhaseIsAnimating: Bool = false
    @State private var secondPhaseIsAnimating: Bool = false
    
    private let timer = Timer.publish(every: 0.35, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            
            Color.accentColor.ignoresSafeArea()
            
            Image("KeelungLogo")
                .resizable()
                .frame(width: UIScreen.main.bounds.width/2.5, height: UIScreen.main.bounds.width/2.5)
                .scaleEffect(firstPhaseIsAnimating ? 0.6 : 1)
                .scaleEffect(secondPhaseIsAnimating ? UIScreen.main.bounds.size.height / 4 : 1)
        }
        .onReceive(timer) { input in
            
            switch launchScreenManager.state {
            case .first:
                withAnimation(.spring()) {
                    firstPhaseIsAnimating.toggle()
                }
            case .second:
                withAnimation(.easeInOut) {
                    secondPhaseIsAnimating.toggle()
                }
            default: break
            }
            
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenManager())
    }
}
