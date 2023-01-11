//
//  DomainFeature.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


//public struct DomainFeature<Event>: DomainScenario {
//    public typealias Trigger = Event
//    public typealias Effect = Event
//    public typealias ToFeatured = DomainFeature<Event>
//    
//    private let _transit: Mapper<Event, DomainFeature<Event>?>
//    
//    public init(transit: @escaping Mapper<Event, DomainFeature<Event>?>) {
//        self._transit = transit
//    }
//    
//    public func transit(event: Event) -> DomainFeature<Event>? {
//        _transit(event)
//    }
//}
