//
//  ChildlessFeatureObject.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public struct ChildlessFeatureObject<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect, ToFeature: FeatureProtocol>
: ChildlessFeatureProtocol where
ToFeature.InternalTrigger == InternalTrigger,
ToFeature.InternalEffect == InternalEffect,
ToFeature.ExternalTrigger == ExternalTrigger,
ToFeature.ExternalEffect == ExternalEffect {
    
    private let _transit: Mapper<ExternalTrigger, ChildlessFeatureTransition<ToFeature>?>

    public init(transit: @escaping Mapper<ExternalTrigger, ChildlessFeatureTransition<ToFeature>?>) {
        self._transit = transit
    }
    
    public init<F: ChildlessFeatureProtocol>(_ feature: F) where F.InternalTrigger == InternalTrigger, F.InternalEffect == InternalEffect, F.ExternalTrigger == ExternalTrigger, F.ExternalEffect == ExternalEffect, F.ToFeature == ToFeature {
        self._transit = feature.transit(input:)
    }
    
    public func transit(input: ExternalTrigger) -> ChildlessFeatureTransition<ToFeature>? {
        self._transit(input)
    }
}
