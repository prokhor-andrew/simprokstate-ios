//
//  DomainFeatureStrictObject.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public struct DomainFeatureStrictObject<Event>: DomainFeatureStrictProtocol {
    public typealias Trigger = Event
    public typealias Effect = Event
    public typealias ToFeature = DomainFeatureStrictObject<Event>
    
    private let _transit: Mapper<Event, ToFeature?>
    
    public init(transit: @escaping Mapper<Event, ToFeature?>) {
        self._transit = transit
    }
    
    public init<F: DomainFeatureStrictProtocol>(_ feature: F) where F.ExternalTrigger == Event, F.ExternalEffect == Event {
        self._transit = { event in
            if let new = feature.transit(event: event) {
                return DomainFeatureStrictObject(new)
            } else {
                return nil
            }
        }
    }
    
    public func transit(event: Event) -> ToFeature? {
        _transit(event)
    }
}
