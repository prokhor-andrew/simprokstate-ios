//
//  FeatureAutomaton.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public protocol FeatureAutomaton: ParentAutomaton {
    associatedtype F: FeatureProtocol
    
    var feature: FeatureTransition<F> { get }
}


public extension FeatureAutomaton {
    
    var child: FeatureMachine<F.InternalTrigger, F.InternalEffect, F.ExternalTrigger, F.ExternalEffect> {
        FeatureMachine(feature)
    }
}
