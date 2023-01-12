//
//  FeatureProtocol.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

public protocol FeatureProtocol {
    associatedtype Trigger
    associatedtype Effect

    associatedtype ToFeature: FeatureProtocol where ToFeature.Trigger == Trigger, ToFeature.Effect == Effect
    
    var machines: [ParentAutomaton<Effect, Trigger>] { get }
    
    func transit(trigger: FeatureEvent<Trigger>) -> FeatureTransition<ToFeature>?
}
