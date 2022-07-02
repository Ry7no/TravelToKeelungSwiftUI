//
//  Location.swift
//  TravelToKeelungSwiftUI
//
//  Created by Br7 on 2022/6/18.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageUrl: String
    let imageTitle: String
    let phone: String
    let address: String
    let link: String

    var id: String {
        name + cityName
    }

    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}

struct LocationFromJson: Codable {

    let cName, eName, cToldescribe, eToldescribe: String
    let coastalActivities, amenities, px, py: String
    let tel, cAdd, eAdd, opentime: String
    let openremarkC, openremarkE: String
    let picture1: String
    let picdescribe1C, picdescribe1E, picture2, picdescribe2C: String
    let picdescribe2E, website, ticketinfo, remarks: String
    let facebook, twitter, video, mapLink: String
    let changtime: String

    enum CodingKeys: String, CodingKey {
        case cName = "CName"
        case eName = "EName"
        case cToldescribe = "CToldescribe"
        case eToldescribe = "EToldescribe"
        case coastalActivities = "CoastalActivities"
        case amenities = "Amenities"
        case px = "Px"
        case py = "Py"
        case tel = "Tel"
        case cAdd = "CAdd"
        case eAdd = "EAdd"
        case opentime = "Opentime"
        case openremarkC = "OpenremarkC"
        case openremarkE = "OpenremarkE"
        case picture1 = "Picture1"
        case picdescribe1C = "Picdescribe1C"
        case picdescribe1E = "Picdescribe1E"
        case picture2 = "Picture2"
        case picdescribe2C = "Picdescribe2C"
        case picdescribe2E = "Picdescribe2E"
        case website = "Website"
        case ticketinfo = "Ticketinfo"
        case remarks = "Remarks"
        case facebook = "Facebook"
        case twitter = "Twitter"
        case video = "Video"
        case mapLink = "MapLink"
        case changtime = "Changtime"
    }
}

extension CLLocation {

    func drive() {

        let placemark = MKPlacemark(coordinate: self.coordinate)

        let launchOptions = [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ]

        MKMapItem.openMaps(with: [MKMapItem.forCurrentLocation(), MKMapItem(placemark: placemark)], launchOptions: launchOptions)

    }
}

/*
00 CName,
01 EName,
02 CToldescribe,
03 EToldescribe,
04 CoastalActivities,
05 Amenities,
06 Px,
07 Py,
08 Tel,
09 CAdd,
10 EAdd,
11 Opentime,
12 OpenremarkC,
13 OpenremarkE,
14 Picture1,
15 Picdescribe1C,
16 Picdescribe1E,
17 Picture2,
18 Picdescribe2C,
19 Picdescribe2E,
20 Website,
21 Ticketinfo,
22 Remarks,
23 Facebook,
24 Twitter,
25 Video,
26 MapLink,
27 Changtime
*/
