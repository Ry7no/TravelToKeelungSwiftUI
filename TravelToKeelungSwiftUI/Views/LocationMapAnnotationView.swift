//
//  LocationMapAnnotationView.swift
//  TravelToKeelungSwiftUI
//
//  Created by Br7 on 2022/6/20.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    
    @EnvironmentObject private var locationsVM: LocationsViewModel
    let accentColor = Color("AccentColor")
    let location: Location
    
    var body: some View {
        VStack(spacing: 0) {
            
            Image(location.name)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
//                .scaledToFit()
//                .frame(width: 30, height: 30)
//                .font(.headline)
                .foregroundColor(.white)
//                .padding(6)
                .background(accentColor)
                .clipShape(Circle())
                .overlay(Circle().stroke(lineWidth: 3).foregroundColor(accentColor))
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(accentColor)
                .frame(width: 8, height: 8)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -2)
                .padding(.bottom, 40)
        }
        
    }
}

//struct LocationMapAnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationMapAnnotationView()
//    }
//}
