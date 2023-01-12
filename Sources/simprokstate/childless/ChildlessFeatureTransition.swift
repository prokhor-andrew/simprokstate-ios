//
//  ChildlessFeatureTransition.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


public struct ChildlessFeatureTransition<F: FeatureProtocol> {
    
    public let state: F
    public let effects: [F.Effect]
    
    public init(_ state: F, effects: F.Effect...) {
        self.init(state, effects: effects)
    }
    
    public init(_ state: F, effects: [F.Effect]) {
        self.state = state
        self.effects = effects
    }
}
