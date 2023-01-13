//
//  FeatureSelfishObject.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

// MARK: additional initializer 
public struct FeatureSelfishObject<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect>: FeatureSelfishProtocol {
    public typealias ToFeature = FeatureSelfishObject<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect>
    
    public let machines: [ParentAutomaton<InternalEffect, InternalTrigger>]
    
    private let _transit: Mapper<FeatureEvent<InternalTrigger, ExternalTrigger>, FeatureTransition<ToFeature>?>
    
    public init(
        machines: [ParentAutomaton<InternalEffect, InternalTrigger>],
        transit: @escaping Mapper<FeatureEvent<InternalTrigger, ExternalTrigger>, FeatureTransition<ToFeature>?>
    ) {
        self.machines = machines
        self._transit = transit
    }
    
    public init<F: FeatureProtocol>(_ feature: F) where F.InternalTrigger == InternalTrigger, F.InternalEffect == InternalEffect, F.ExternalTrigger == ExternalTrigger, F.ExternalEffect == ExternalEffect {
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
    
    public func transit(trigger: FeatureEvent<InternalTrigger, ExternalTrigger>) -> FeatureTransition<ToFeature>? {
        _transit(trigger)
    }
}
