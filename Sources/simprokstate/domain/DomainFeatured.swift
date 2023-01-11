//
//  DomainFeatured.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


public protocol DomainFeatured: ChildlessFeatured where Trigger == Effect {
    
    
    func transit(event: Trigger) -> ToFeatured?
}


public extension DomainFeatured {
    
    func transit(input: Trigger) -> ChildlessFeatureTransition<ToFeatured>? {
        if let newState = transit(event: input) {
            return ChildlessFeatureTransition(newState, effects: input)
        } else {
            return nil
        }
    }
}
