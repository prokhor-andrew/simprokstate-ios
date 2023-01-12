//
//  FeatureObject.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

// MARK: additional initializer 
public struct FeatureObject<Trigger, Effect, ToFeature: FeatureProtocol>: FeatureProtocol where ToFeature.Trigger == Trigger, ToFeature.Effect == Effect {
    
    public let machines: [ParentAutomaton<Effect, Trigger>]
    
    private let _transit: Mapper<FeatureEvent<Trigger>, FeatureTransition<ToFeature>?>
    
    public init(
        machines: [ParentAutomaton<Effect, Trigger>],
        transit: @escaping Mapper<FeatureEvent<Trigger>, FeatureTransition<ToFeature>?>
    ) {
        self.machines = machines
        self._transit = transit
    }
    
    public init<F: FeatureProtocol>(_ feature: F) where F.Trigger == Trigger, F.Effect == Effect, F.ToFeature == ToFeature {
        self.init(machines: feature.machines, transit: feature.transit(trigger:))
    }
    
    public func transit(trigger: FeatureEvent<Trigger>) -> FeatureTransition<ToFeature>? {
        _transit(trigger)
    }
}
