//
//  DomainFeatureMildObject.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public struct DomainFeatureMildObject<Event, ToFeature: DomainFeatureMildProtocol>
: DomainFeatureMildProtocol where
ToFeature.ExternalTrigger == Event,
ToFeature.ExternalEffect == Event {
   
    public typealias ExternalTrigger = Event
    public typealias ExternalEffect = Event

    private let _transit: Mapper<Event, ToFeature?>

    public init(transit: @escaping Mapper<Event, ToFeature?>) {
        self._transit = transit
    }

    public func transit(event: Event) -> ToFeature? {
        _transit(event)
    }
}
