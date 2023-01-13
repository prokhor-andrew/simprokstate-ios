//
//  FeatureObject.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

// MARK: additional initializer 
public struct FeatureObject<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect, ToFeature: FeatureProtocol>
: FeatureProtocol where
ToFeature.InternalTrigger == InternalTrigger,
ToFeature.InternalEffect == InternalEffect,
ToFeature.ExternalTrigger == ExternalTrigger,
ToFeature.ExternalEffect == ExternalEffect {
    
    public let machines: Machines<InternalEffect, InternalTrigger>
    
    private let _transit: Mapper<FeatureEvent<InternalTrigger, ExternalTrigger>, FeatureTransition<ToFeature>?>
    
    public init(
        machines: Machines<InternalEffect, InternalTrigger>,
        transit: @escaping BiMapper<Machines<InternalEffect, InternalTrigger>, FeatureEvent<InternalTrigger, ExternalTrigger>, FeatureTransition<ToFeature>?>
    ) {
        self.machines = machines
        self._transit = { transit(machines, $0) }
    }
    
    public init<F: FeatureProtocol>(_ feature: F) where F.InternalTrigger == ExternalTrigger, F.InternalEffect == InternalEffect, F.ExternalTrigger == ExternalTrigger, F.ExternalEffect == ExternalEffect, F.ToFeature == ToFeature {
        self.machines = feature.machines
        self._transit = feature.transit(trigger:)
    }
    
    public func transit(trigger: FeatureEvent<InternalTrigger, ExternalTrigger>) -> FeatureTransition<ToFeature>? {
        _transit(trigger)
    }
}
