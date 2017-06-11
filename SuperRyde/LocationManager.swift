//
//  MapManager.swift
//  SuperRyde
//
//  Created by Warren Smith on 6/6/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import Foundation
import MapKit
import RxSwift
import RxCocoa

class LocationManager: NSObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    private let locationSubject = ReplaySubject<CLLocation>.create(bufferSize: 1)

    override init() {
        super.init()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("Don't have app permission to access location.")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Have access to location.")
            }

            locationManager.requestLocation()
        } else {
            print("Don't have access to location services enabled on device.")
        }
    }

    func getlocation() -> Observable<CLLocationCoordinate2D> {
        return locationSubject.asObservable()
            .map { location in
                return location.coordinate
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            locationSubject.onNext(location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationSubject.onError(error)
    }
}
