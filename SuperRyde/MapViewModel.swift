//
//  MapViewModel.swift
//  SuperRyde
//
//  Created by Warren Smith on 5/29/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import Foundation
import RxSwift

class MapViewModel {

    private var lyftApi: LyftApi
    private var uberApi: UberApi

    // Since we can't flatmap a Single to an Observable we subscribe and emit values to a Subject
    // https://github.com/ReactiveX/RxSwift/issues/1206
    private let estimateObservable = PublishSubject<Estimate>()
    private let priceObservable = PublishSubject<Price>()
    private let disposeBag = DisposeBag()

    init(lyftApi: LyftApi, uberApi: UberApi) {
        self.lyftApi = lyftApi
        self.uberApi = uberApi
    }

    func costEstimate(request: CostEstimateRequest) -> Observable<Estimate> {
        lyftApi.authenticate()
            .flatMap({ token -> Single<CostEstimateResponse> in
                return self.lyftApi.loadCostEstimate(token: token, request: request)
            })
            .subscribe { event in
                switch event {
                case .success(let costEstimateResponse):
                    if let estimates = costEstimateResponse.estimates {
                        for estimate in estimates {
                            self.estimateObservable.onNext(estimate)
                        }
                    }
                case .error(let error):
                    self.estimateObservable.onError(error)
                }
            }.addDisposableTo(disposeBag)
        return estimateObservable
    }

    func priceEstimate(request: PriceEstimateRequest) -> Observable<Price> {
        uberApi.loadPriceEstimate(request: request)
            .subscribe { event in
                switch event {
                case .success(let priceEstimateResponse):
                    if let prices = priceEstimateResponse.prices {
                        for price in prices {
                            self.priceObservable.onNext(price)
                        }
                    }
                case .error(let error):
                    self.priceObservable.onError(error)
                }
            }.addDisposableTo(disposeBag)
        return priceObservable
    }
}
