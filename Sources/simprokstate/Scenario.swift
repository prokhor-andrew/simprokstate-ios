//
//  Scenario.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

public struct Scenario<Trigger, Effect, ToFeatured: Featured>: Featured where ToFeatured.Trigger == Trigger, ToFeatured.Effect == Effect {
    
    public let machines: [ParentAutomaton<Effect, Trigger>]
    
    private let _transit: Mapper<FeatureEvent<Trigger>, FeatureTransition<ToFeatured>?>
    
    public init(
        machines: [ParentAutomaton<Effect, Trigger>],
        transit: @escaping Mapper<FeatureEvent<Trigger>, FeatureTransition<ToFeatured>?>
    ) {
        self.machines = machines
        self._transit = transit
    }
    
    public init<F: Featured>(_ featured: F) where F.Trigger == Trigger, F.Effect == Effect, F.ToFeatured == ToFeatured {
        self.init(machines: featured.machines) {
            if let transition = featured.transit(trigger: $0) {
                return transition
            } else {
                return nil
            }
        }
    }
    
    public func transit(trigger: FeatureEvent<Trigger>) -> FeatureTransition<ToFeatured>? {
        _transit(trigger)
    }
}
