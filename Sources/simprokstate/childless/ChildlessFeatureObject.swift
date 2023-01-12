//
//  ChildlessFeatureObject.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public struct ChildlessFeatureObject<Trigger, Effect, ToFeature: FeatureProtocol>: ChildlessFeatureProtocol where ToFeature.Trigger == Trigger, ToFeature.Effect == Effect {
    
    private let _transit: Mapper<Trigger, ChildlessFeatureTransition<ToFeature>?>

    public init(transit: @escaping Mapper<Trigger, ChildlessFeatureTransition<ToFeature>?>) {
        self._transit = transit
    }
    
    public func transit(input: Trigger) -> ChildlessFeatureTransition<ToFeature>? {
        self._transit(input)
    }
}
