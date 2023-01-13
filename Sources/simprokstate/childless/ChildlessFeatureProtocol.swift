//
//  ChildlessFeatureProtocol.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public protocol ChildlessFeatureProtocol: FeatureProtocol {
        
    func transit(input: ExternalTrigger) -> ChildlessFeatureTransition<ToFeature>?
}

public extension ChildlessFeatureProtocol {
    
    var machines: [ParentAutomaton<InternalEffect, InternalTrigger>] { [] }
    
    func transit(trigger: FeatureEvent<InternalTrigger, ExternalTrigger>) -> FeatureTransition<ToFeature>? {
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
