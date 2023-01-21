//
//  FeatureAutomaton.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public protocol FeatureAutomaton: ParentAutomaton {
    associatedtype IntTrigger
    associatedtype IntEffect
    associatedtype ExtTrigger
    associatedtype ExtEffect

    var feature: FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect> { get }
}


public extension FeatureAutomaton {
    
    var child: FeatureMachine<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        FeatureMachine(feature)
    }
}
