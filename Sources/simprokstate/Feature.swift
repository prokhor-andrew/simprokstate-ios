//
//  Feature.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

public struct Feature<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect>: Featured {
    public typealias ToFeatured = Feature<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect>
    
    public let machines: [ParentAutomaton<InternalEffect, InternalTrigger>]
    
    private let _effects: Supplier<[FeatureEvent<InternalEffect, ExternalEffect>]>
    private let _transit: Mapper<FeatureEvent<InternalTrigger, ExternalTrigger>, FeatureTransition<ToFeatured>>
    
    public init(
        machines: [ParentAutomaton<InternalEffect, InternalTrigger>],
        effects: @autoclosure @escaping Supplier<[FeatureEvent<InternalEffect, ExternalEffect>]>,
        transit: @escaping Mapper<FeatureEvent<InternalTrigger, ExternalTrigger>, FeatureTransition<ToFeatured>>
    ) {
        self.machines = machines
        self._effects = effects
        self._transit = transit
    }
    
    public init<F: Featured>(_ featured: F) where
        F.InternalTrigger == InternalTrigger,
        F.InternalEffect == InternalEffect,
        F.ExternalTrigger == ExternalTrigger,
        F.ExternalEffect == ExternalEffect {
            self.init(machines: featured.machines, effects: featured.effects()) {
                switch featured.transit(trigger: $0) {
                case .skip:
                    return .skip
                case .set(let new):
                    return .set(Feature(new))
                }
            }
    }
    
    public func transit(trigger: FeatureEvent<InternalTrigger, ExternalTrigger>) -> FeatureTransition<ToFeatured> {
        _transit(trigger)
    }
    
    public func effects() -> [FeatureEvent<InternalEffect, ExternalEffect>] {
        _effects()
    }
}
