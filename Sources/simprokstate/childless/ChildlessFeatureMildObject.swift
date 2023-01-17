//
//  ChildlessFeatureMildObject.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public struct ChildlessFeatureMildObject<Trigger, Effect, ToFeature: ChildlessFeatureMildProtocol>: ChildlessFeatureMildProtocol where ToFeature.ExternalTrigger == Trigger, ToFeature.ExternalEffect == Effect {
    
    public typealias ExternalTrigger = Trigger
    public typealias ExternalEffect = Effect
    
    private let _transit: Mapper<Trigger, ChildlessFeatureTransition<ToFeature>?>

    public init(transit: @escaping Mapper<Trigger, ChildlessFeatureTransition<ToFeature>?>) {
        self._transit = transit
    }
    
    public init<F: ChildlessFeatureMildProtocol>(_ feature: F) where F.ExternalTrigger == Trigger, F.ExternalEffect == Effect, F.ToFeature == ToFeature {
        self._transit = feature.transit(input:)
    }
    
    public func transit(input: Trigger) -> ChildlessFeatureTransition<ToFeature>? {
        self._transit(input)
    }
}
