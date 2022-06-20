//
//  LocationDetailView.swift
//  TravelToKeelungSwiftUI
//
//  Created by Br7 on 2022/6/20.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit

struct LocationDetailView: View {
    
    @EnvironmentObject private var locationsVM: LocationsViewModel
    
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
          }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topTrailing)
    }
}

extension LocationDetailView {
    
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
//            AsyncImage(url: URL(string: location.imageUrl)) { image in
//                image.resizable()
//            } placeholder: {
//                Color.white
//            }
//            WebImage(url: URL(string: location.imageUrl))
//                .resizable()
//                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
                .clipped()
        }
        .frame(height: 400)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
        }
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
            annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .shadow(radius: 10)
            }
        }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)
            .shadow(radius: 1)
    }
    
    private var backButton: some View {
        Button {
            locationsVM.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
}

//struct LocationDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationDetailView(location: DataService.locations.first!)
//            .environmentObject(LocationsViewModel())
//    }
//}
