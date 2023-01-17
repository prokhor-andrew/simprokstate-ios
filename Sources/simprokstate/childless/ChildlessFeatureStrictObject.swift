//
//  ChildlessFeatureStrictObject.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public struct ChildlessFeatureStrictObject<Trigger, Effect>: ChildlessFeatureStrictProtocol {
    public typealias ExternalTrigger = Trigger
    public typealias ExternalEffect = Effect
    public typealias ToFeature = ChildlessFeatureStrictObject<Trigger, Effect>
    
    
    private let _transit: Mapper<Trigger, ChildlessFeatureTransition<ToFeature>?>

    public init(transit: @escaping Mapper<Trigger, ChildlessFeatureTransition<ToFeature>?>) {
        self._transit = transit
    }
    
    public init<F: ChildlessFeatureStrictProtocol>(_ feature: F) where F.ExternalTrigger == ExternalTrigger, F.ExternalEffect == ExternalEffect {
        self._transit = {
            if let transition = feature.transit(input: $0) {
                let state = ChildlessFeatureStrictObject(transition.state)
                let effects = transition.effects
                return ChildlessFeatureTransition(state, effects: effects)
            } else {
                return nil
            }
        }
    }
    
    public func transit(input: Trigger) -> ChildlessFeatureTransition<ToFeature>? {
        self._transit(input)
    }
}
