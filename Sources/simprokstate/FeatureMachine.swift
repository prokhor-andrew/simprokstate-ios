//
//  FeatureMachine.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public protocol FeatureMachine: ParentMachine {
    associatedtype F: FeatureProtocol
    
    var feature: FeatureTransition<F> { get }
}


public extension FeatureMachine {
    
    var child: FeatureAutomaton<F.InternalTrigger, F.InternalEffect, F.ExternalTrigger, F.ExternalEffect> {
        FeatureAutomaton(feature)
    }
}
