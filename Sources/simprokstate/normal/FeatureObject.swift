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
    
    public let machines: [ParentAutomaton<InternalEffect, InternalTrigger>]
    
    private let _transit: Mapper<FeatureEvent<InternalTrigger, ExternalTrigger>, FeatureTransition<ToFeature>?>
    
    public init(
        machines: [ParentAutomaton<InternalEffect, InternalTrigger>],
        transit: @escaping Mapper<FeatureEvent<InternalTrigger, ExternalTrigger>, FeatureTransition<ToFeature>?>
    ) {
        self.machines = machines
        self._transit = transit
    }
    
    public init<F: FeatureProtocol>(_ feature: F) where F.InternalTrigger == ExternalTrigger, F.InternalEffect == InternalEffect, F.ExternalTrigger == ExternalTrigger, F.ExternalEffect == ExternalEffect, F.ToFeature == ToFeature {
        self.init(machines: feature.machines, transit: feature.transit(trigger:))
    }
    
    public func transit(trigger: FeatureEvent<InternalTrigger, ExternalTrigger>) -> FeatureTransition<ToFeature>? {
        _transit(trigger)
    }
}
