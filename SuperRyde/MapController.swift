//
//  ViewController.swift
//  SuperRyde
//
//  Created by Warren Smith on 5/27/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import UIKit

import GooglePlaces
import SnapKit
import MapKit
import RxSwift
import RxCocoa

class MapController: UIViewController {

    let mapViewModel = MapViewModel(lyftApi: LyftApi(), uberApi: UberApi())
    let destinationView = DestinationView()
    let mapView = MapView()

    let locationManager = LocationManager()
    let destinationSubject = ReplaySubject<GMSPlace>.create(bufferSize: 1)
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let superview = self.view!

        superview.addSubview(mapView.map)
        superview.addSubview(destinationView.textField)

        mapView.map.snp.makeConstraints { make -> Void in
            make.width.equalTo(self.view)
            make.height.equalTo(self.view)
            make.center.equalTo(self.view)
        }

        destinationView.textField.snp.makeConstraints { make -> Void in
            make.top.equalTo(superview).offset(100)
            make.height.equalTo(40)
            make.left.equalTo(superview).offset(30)
            make.right.equalTo(superview).offset(-30)
        }

        locationManager.getlocation()
            .subscribe { coordinate in
                let center = CLLocationCoordinate2D(latitude: coordinate.element!.latitude, longitude: coordinate.element!.longitude)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                self.mapView.map.setRegion(region, animated: true)
            }.addDisposableTo(disposeBag)

        destinationView.textField
            .rx
            .controlEvent([.touchDown])
            .asObservable()
            .subscribe { event in
                let autocompleteController = GMSAutocompleteViewController()
                autocompleteController.delegate = self
                self.present(autocompleteController, animated: true, completion: nil)
            }.addDisposableTo(disposeBag)

        destinationSubject.subscribe(onNext: { location in
            self.destinationView.textField.text = location.formattedAddress
            self.dismiss(animated: true, completion: nil)


        }).addDisposableTo(disposeBag)

        Observable.zip(locationManager.getlocation(), destinationSubject.asObservable()).subscribe{ element in
            let start = element.element?.0
            let end = element.element?.1.coordinate

            let directionRequest = MKDirectionsRequest()
            directionRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: start!, addressDictionary: nil))
            directionRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: end!, addressDictionary: nil))
            directionRequest.transportType = .automobile

            let directions = MKDirections(request: directionRequest)

            directions.calculate {
                (response, error) -> Void in

                guard let response = response else {
                    if let error = error {
                        print("Error: \(error)")
                    }
                    return
                }

                let route = response.routes[0]
                self.mapView.map.add(route.polyline, level: MKOverlayLevel.aboveRoads)

                let rect = route.polyline.boundingMapRect
                self.mapView.map.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            }
        }.addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MapController: GMSAutocompleteViewControllerDelegate {

    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        destinationSubject.onNext(place)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        self.dismiss(animated: true, completion: nil)
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }

    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

//        locationManager.getlocation()
//            .flatMap { coordinate -> Observable<Estimate> in
//                return self.mapViewModel.costEstimate(request: CostEstimateRequest(
//                    startLat: 37.7752315,
//                    startLong: -122.418075,
//                    endLat: 37.7752415,
//                    endLong: -122.518075))
//            } .subscribe { event in
//                switch event {
//                case .next(let estimate):
//                    print(estimate.displayName)
//                default:
//                    print("Error")
//                }
//            }
//            .addDisposableTo(disposeBag)
//
//        locationManager.getlocation()
//            .flatMap { coordinate -> Observable<Price> in
//                return self.mapViewModel.priceEstimate(request: PriceEstimateRequest(
//                    startLat: 37.7752315,
//                    startLong: -122.418075,
//                    endLat: 37.7752415,
//                    endLong: -122.518075))
//            }.subscribe { event in
//                switch event {
//                case .next(let price):
//                    print(price.displayName)
//                default:
//                    print("Error")
//                }
//            }.addDisposableTo(disposeBag)
