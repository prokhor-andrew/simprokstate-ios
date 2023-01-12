//
//  DomainFeatureProtocol.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


public protocol DomainFeatureProtocol: ChildlessFeatureProtocol where Trigger == Effect {
    
    
    func transit(event: Trigger) -> ToFeature?
}


public extension DomainFeatureProtocol {
    
    func transit(input: Trigger) -> ChildlessFeatureTransition<ToFeature>? {
        if let newState = transit(event: input) {
            return ChildlessFeatureTransition(newState, effects: input)
        } else {
            return nil
        }
    }
}
