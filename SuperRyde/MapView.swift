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
class MapView: NSObject, MKMapViewDelegate {

    let map = MKMapView()

    override init() {
        super.init()

        map.delegate = self
        map.mapType = .standard
        map.showsPointsOfInterest = true
        map.showsTraffic = true
        map.showsCompass = true
        map.showsScale = true
        map.showsUserLocation = true
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0

        return renderer
    }
}
