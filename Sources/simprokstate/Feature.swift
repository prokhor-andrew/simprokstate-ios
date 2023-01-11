//
//  Feature.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

public struct Feature<Trigger, Effect>: Featured {
    public typealias ToFeatured = Feature<Trigger, Effect>
    
    public let machines: [ParentAutomaton<Effect, Trigger>]
    
    private let _transit: Mapper<FeatureEvent<Trigger>, FeatureTransition<ToFeatured>?>
    
    public init(
        machines: [ParentAutomaton<Effect, Trigger>],
        transit: @escaping Mapper<FeatureEvent<Trigger>, FeatureTransition<ToFeatured>?>
    ) {
        self.machines = machines
        self._transit = transit
    }
    
    public init<F: Featured>(_ featured: F) where F.Trigger == Trigger, F.Effect == Effect {
        self.init(machines: featured.machines) {
            if let transition = featured.transit(trigger: $0) {
                return FeatureTransition(Feature(transition.state), effects: transition.effects)
            } else {
                return nil
            }
        }
    }
    
    public func transit(trigger: FeatureEvent<Trigger>) -> FeatureTransition<ToFeatured>? {
        _transit(trigger)
    }
}
