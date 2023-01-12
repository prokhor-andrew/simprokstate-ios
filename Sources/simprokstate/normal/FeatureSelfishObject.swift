//
//  FeatureSelfishObject.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

// MARK: additional initializer 
public struct FeatureSelfishObject<Trigger, Effect>: FeatureSelfishProtocol {
    public typealias ToFeature = FeatureSelfishObject<Trigger, Effect>
    
    public let machines: [ParentAutomaton<Effect, Trigger>]
    
    private let _transit: Mapper<FeatureEvent<Trigger>, FeatureTransition<ToFeature>?>
    
    public init(
        machines: [ParentAutomaton<Effect, Trigger>],
        transit: @escaping Mapper<FeatureEvent<Trigger>, FeatureTransition<ToFeature>?>
    ) {
        self.machines = machines
        self._transit = transit
    }
    
    public init<F: FeatureProtocol>(_ feature: F) where F.Trigger == Trigger, F.Effect == Effect {
        self.init(machines: feature.machines) {
            if let transition = feature.transit(trigger: $0) {
                let state = FeatureSelfishObject(transition.state)
                let effects = transition.effects
                return FeatureTransition(state, effects: effects)
            } else {
                return nil
            }
        }
    }
    
    public func transit(trigger: FeatureEvent<Trigger>) -> FeatureTransition<ToFeature>? {
        _transit(trigger)
    }
}
