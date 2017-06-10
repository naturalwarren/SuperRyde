//
//  MapView.swift
//  SuperRyde
//
//  Created by Warren Smith on 6/10/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import Foundation
import MapKit

// A wrapper around MKMapView that preconfigures it to display traffic and user location.
class MapView {

    let map = MKMapView()

    init() {
        map.mapType = .standard
        map.showsTraffic = true
        map.showsCompass = true
        map.showsScale = true
        map.showsUserLocation = true
    }
}
