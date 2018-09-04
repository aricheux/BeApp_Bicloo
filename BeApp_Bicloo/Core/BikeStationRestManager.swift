//
//  BikeStationRestManager.swift
//  BeApp_Bicloo
//
//  Created by Antoine Richeux on 04/09/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class BikeStationRestManager {
    
    static let shared = BikeStationRestManager()
    private let provider = MoyaProvider<BikeStationAPI>()
    
    func getBikeStationObservable() -> Observable<[BikeStationDTO]> {
        return provider.rx.request(.bikeStation)
        .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        .asObservable()
        .map([BikeStationDTO].self)
    }

}
