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
    @State private var showActionSheet = false
    
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    detailedButton
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
            Image(location.name)
                .resizable()
                .scaledToFill()
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
            
            if let url = URL(string: location.link) {
                Link("詳見維基百科", destination: url)
                    .font(.headline)
                    .tint(.blue)
                    .padding([.top], 10)
            }
            
        }
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
            annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView(location: location)
                    .shadow(radius: 10)
            }
        }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)
            .shadow(radius: 1)
    }
    
    private var detailedButton: some View {
        
        Button {
            showActionSheet.toggle()
        } label: {
            
            VStack (alignment: .leading, spacing: 10) {
                
                HStack{
                    Image(systemName: "phone.circle.fill")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    Text(location.phone)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                HStack{
                    Image(systemName: "map.circle.fill")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    Text(location.address)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
        }
        .confirmationDialog("", isPresented: $showActionSheet) {
            
            Button {
                guard let number = URL(string: "tel://\(location.phone)") else { return }
                UIApplication.shared.open(number)
            } label: {
                Text("撥打電話")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            
            Button {
                let latitude = location.coordinates.latitude
                let longitude = location.coordinates.longitude
                if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
                    UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)")!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=loc:\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)")!, options: [:], completionHandler: nil)
                }
            } label: {
                Text("查看 Google Map")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            
        }
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
