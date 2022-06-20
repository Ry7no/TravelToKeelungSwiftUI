//
//  LocationsView.swift
//  TravelToKeelungSwiftUI
//
//  Created by Br7 on 2022/6/19.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var locationsVM: LocationsViewModel
    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                    .padding()
                
                Spacer()
                locationPreviewStack
            }
        }
        .sheet(item: $locationsVM.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsView {
    
    private var header: some View {
        
        VStack {
            Button {
                locationsVM.toggleLocationsList()
            } label: {
                Text(locationsVM.mapLocation.name + ", " + locationsVM.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: locationsVM.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "chevron.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: locationsVM.showLocationList ? 180 : 0))
                    }
            }

            if locationsVM.showLocationList {
                LocationsListView()
            }
        }
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 5, y: 5)
        
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: $locationsVM.mapRegion,
            annotationItems: locationsVM.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(locationsVM.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        locationsVM.showNextLocation(location: location)
                    }
            }
        })
    }
    
    private var locationPreviewStack: some View {
        ZStack {
            ForEach(locationsVM.locations) { location in
                
                if locationsVM.mapLocation == location {
                    LocationPreview(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 5, y: 5)
                        .padding()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}
