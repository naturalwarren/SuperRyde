//
//  ViewController.swift
//  SuperRyde
//
//  Created by Warren Smith on 5/27/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import UIKit

import SnapKit
import MapKit
import RxSwift
import RxCocoa

class MapController: UIViewController {

    let mapViewModel = MapViewModel(lyftApi: LyftApi(), uberApi: UberApi())

    let locationManager = LocationManager()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let superview = self.view!
        let destinationView = DestinationView()
        let mapView = MapView()

        superview.addSubview(mapView.map)
        superview.addSubview(destinationView.textField)

        mapView.map.snp.makeConstraints { make -> Void in
            make.width.equalTo(self.view)
            make.height.equalTo(self.view)
            make.center.equalTo(self.view)
        }

        destinationView.textField.snp.makeConstraints { make -> Void in
            make.top.equalTo(superview).offset(100)
            make.left.equalTo(superview).offset(20)
            make.right.equalTo(superview).offset(-20)
        }

//        mapViewModel.costEstimate(request: CostEstimateRequest(startLat: 37.7752315, startLong: -122.418075, endLat: 37.7752415, endLong: -122.518075))
//            .subscribe { event in
//                switch event {
//                case .next(let estimate):
//                    print(estimate.displayName)
//                default:
//                    print("Error")
//                }
//            }
//            .addDisposableTo(disposeBag)
//
//        mapViewModel.priceEstimate(request: PriceEstimateRequest(startLat: 37.7752315, startLong: -122.418075, endLat: 37.7752415, endLong: -122.518075))
//            .subscribe { event in
//                switch event {
//                case .next(let price):
//                    print(price.displayName)
//                default:
//                    print("Error")
//                }
//            }.addDisposableTo(disposeBag)

        locationManager.getlocation()
            .subscribe { location in
                let center = CLLocationCoordinate2D(latitude: location.element!.coordinate.latitude, longitude: location.element!.coordinate.longitude)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                mapView.map.setRegion(region, animated: true)
            }.addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

