//
//  ChildlessFeature.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public struct ChildlessFeature<Trigger, Effect>: ChildlessFeatured {
    public typealias Trigger = Trigger
    public typealias Effect = Effect
    public typealias ToFeatured = ChildlessFeature<Trigger, Effect>
    
    private let _transit: Mapper<Trigger, ChildlessFeatureTransition<ChildlessFeature<Trigger, Effect>>?>
    
    public init(transit: @escaping Mapper<Trigger, ChildlessFeatureTransition<ChildlessFeature<Trigger, Effect>>?>) {
        self._transit = transit
    }
    
    public func transit(input: Trigger) -> ChildlessFeatureTransition<ChildlessFeature<Trigger, Effect>>? {
        _transit(input)
    }
}
