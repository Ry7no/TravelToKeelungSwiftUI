//
//  LocationPreview.swift
//  TravelToKeelungSwiftUI
//
//  Created by Br7 on 2022/6/19.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit

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
                
                HStack {
                    learnMoreButton
                    navigationButton
                }
                
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
            
//            AsyncImage(url: URL(string: location.imageUrl), transaction: Transaction(animation: .spring())) { phase in
//                switch phase {
//                case .empty:
//                    Color.red.opacity(0.1)
//
//                case .success(let image):
//                    image
//                        .resizable()
//                        .scaledToFill()
//
//                case .failure(_):
//                    Image(systemName: "exclamationmark.icloud")
//                        .resizable()
//                        .scaledToFit()
//
//                @unknown default:
//                    Image(systemName: "exclamationmark.icloud")
//                }
//            }
            Image(location.name)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
        }
        .padding(6)
        .background(Color.accentColor.opacity(0.7))
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
            Text("詳細")
                .font(.headline)
                .frame(width: 65, height: 35)
        }
        .buttonStyle(.borderedProminent)
        
    }
    
    private var navigationButton: some View {
        Button {
            locationsVM.openMapsAppWithDirections(to: location.coordinates, destinationName: location.name)
        } label: {
//            Image(systemName: "mappin.and.ellipse")
            Text("導航")
                .font(.headline)
                .frame(width: 40, height: 35)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color("DarkAccent"))
    }
    
    private var nextButton: some View {
        Button {
            locationsVM.nextButtonPressed()
        } label: {
            Text("下個景點")
                .font(.headline)
                .frame(width: 140, height: 35)
        }
        .buttonStyle(.bordered)
        .tint(.accentColor)
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
