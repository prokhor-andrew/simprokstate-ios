//
//  FeatureTransition.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


public struct FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {

    public let state: FeatureObject<IntTrigger, IntEffect, ExtTrigger, ExtEffect>
    public let effects: [FeatureEvent<IntEffect, ExtEffect>]

    public init(
            _ state: FeatureObject<IntTrigger, IntEffect, ExtTrigger, ExtEffect>,
            effects: FeatureEvent<IntEffect, ExtEffect>...
    ) {
        self.init(state, effects: effects)
    }

    public init(
            _ state: FeatureObject<IntTrigger, IntEffect, ExtTrigger, ExtEffect>,
            effects: [FeatureEvent<IntEffect, ExtEffect>]
    ) {
        self.state = state
        self.effects = effects
    }
}
