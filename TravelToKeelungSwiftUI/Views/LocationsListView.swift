//
//  LocationsListView.swift
//  TravelToKeelungSwiftUI
//
//  Created by Br7 on 2022/6/19.
//

import SwiftUI
import SDWebImageSwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject private var LocationsVM: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(LocationsVM.locations) { location in
                Button {
                    LocationsVM.showNextLocation(location: location)
                } label: {
                    listRowView(location: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
         
            }
        }
        .listStyle(PlainListStyle())
    }
}

extension LocationsListView {
     
    private func listRowView(location: Location) -> some View {
        HStack {
            
            Image(location.name)
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .cornerRadius(10)
            
            
//            if !location.imageUrl.isEmpty {
//                AsyncImage(url: URL(string: location.imageUrl), transaction: Transaction(animation: .spring())) { phase in
//                    switch phase {
//                    case .empty:
//                        Color.red.opacity(0.1)
//                        
//                    case .success(let image):
//                        image
//                            .resizable()
//                            .scaledToFill()
//                        
//                    case .failure(_):
//                        Image(systemName: "exclamationmark.icloud")
//                            .resizable()
//                            .scaledToFit()
//                        
//                    @unknown default:
//                        Image(systemName: "exclamationmark.icloud")
//                    }
//                }
//                .frame(width: 45, height: 45)
//                .cornerRadius(10)
//            } else {
//                Image(systemName: "photo.on.rectangle.angled")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 45, height: 45)
//                    .cornerRadius(10)
//            }

            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
            .environmentObject(LocationsViewModel())
    }
}
