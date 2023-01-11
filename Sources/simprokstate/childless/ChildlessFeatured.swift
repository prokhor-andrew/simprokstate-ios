//
//  ChildlessFeatured.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

public struct ChildlessFeatureTransition<F: Featured> {
    
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


public protocol ChildlessFeatured: Featured {
        
    func transit(input: Trigger) -> ChildlessFeatureTransition<ToFeatured>?
}

public extension ChildlessFeatured {
    
    var machines: [ParentAutomaton<Effect, Trigger>] { [] }
    
    func transit(trigger: FeatureEvent<Trigger>) -> FeatureTransition<ToFeatured>? {
        switch trigger {
        case .int:
            return nil
        case .ext(let value):
            if let transition = transit(input: value) {
                return FeatureTransition(transition.state, effects: transition.effects.map { .ext($0) })
            } else {
                return nil
            }
        }
    }
}
