//
//  LocationPreview.swift
//  TravelToKeelungSwiftUI
//
//  Created by Br7 on 2022/6/19.
//

import SwiftUI
import SDWebImageSwiftUI

struct LocationPreview: View {
    
    @EnvironmentObject private var locationsVM: LocationsViewModel
    
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack(spacing: 8) {
                learnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
        
    }
}

extension LocationPreview {
    
    private var imageSection: some View {
        
        ZStack {
            
            AsyncImage(url: URL(string: location.imageUrl), transaction: Transaction(animation: .spring())) { phase in
                switch phase {
                case .empty:
                    Color.red.opacity(0.1)

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                case .failure(_):
                    Image(systemName: "exclamationmark.icloud")
                        .resizable()
                        .scaledToFit()

                @unknown default:
                    Image(systemName: "exclamationmark.icloud")
                }
            }
//            AsyncImage(url: URL(string: location.imageUrl)) {image in
//                image.resizable()
//            } placeholder: {
//                Color.white
//            }
//            WebImage(url: URL(string: location.imageUrl))
//                .resizable()
//                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .cornerRadius(10)
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button {
            locationsVM.sheetLocation = location
        } label: {
            Text("詳細資訊")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            locationsVM.nextButtonPressed()
        } label: {
            Text("下個景點")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}

//struct LocationPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            Color.green.ignoresSafeArea()
//            
//            LocationPreview(location: DataService.locations.first!)
//                .padding()
//        }
//        .environmentObject(LocationsViewModel())
//        
//    }
//}
