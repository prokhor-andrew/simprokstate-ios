//
//  FeatureTransition.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


public struct FeatureTransition<F: Featured> {
    
    public let state: F
    public let effects: [FeatureEvent<F.Effect>]
    
    public init(_ state: F, effects: FeatureEvent<F.Effect>...) {
        self.init(state, effects: effects)
    }
    
    public init(_ state: F, effects: [FeatureEvent<F.Effect>]) {
        self.state = state
        self.effects = effects
    }
}
