//
//  FeatureTransition.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


public struct FeatureTransition<F: FeatureProtocol> {
    
    public let state: F
    public let effects: [FeatureEvent<F.InternalEffect, F.ExternalEffect>]
    
    public init(_ state: F, effects: FeatureEvent<F.InternalEffect, F.ExternalEffect>...) {
        self.init(state, effects: effects)
    }
    
    public init(_ state: F, effects: [FeatureEvent<F.InternalEffect, F.ExternalEffect>]) {
        self.state = state
        self.effects = effects
    }
}
