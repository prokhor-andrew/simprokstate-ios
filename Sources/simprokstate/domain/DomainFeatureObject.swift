//
//  DomainFeatureObject.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public struct DomainFeatureObject<Event, ToFeature: FeatureProtocol>: DomainFeatureProtocol where ToFeature.Trigger == Event, ToFeature.Effect == Event {
    public typealias Trigger = Event
    public typealias Effect = Event
    
    private let _transit: Mapper<Event, ToFeature?>
    
    public init(transit: @escaping Mapper<Event, ToFeature?>) {
        self._transit = transit
    }
    
    public func transit(event: Event) -> ToFeature? {
        _transit(event)
    }
}
