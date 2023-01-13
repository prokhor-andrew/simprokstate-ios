//
//  DomainFeatureProtocol.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


public protocol DomainFeatureProtocol: ChildlessFeatureProtocol where ExternalTrigger == Event, ExternalEffect == Event {
    associatedtype Event
    
    func transit(event: Event) -> ToFeature?
}


public extension DomainFeatureProtocol {
    
    func transit(input: ExternalTrigger) -> ChildlessFeatureTransition<ToFeature>? {
        if let newState = transit(event: input) {
            return ChildlessFeatureTransition(newState, effects: input)
        } else {
            return nil
        }
    }
}
