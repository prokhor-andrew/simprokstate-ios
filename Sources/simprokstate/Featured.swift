//
//  Featured.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

public protocol Featured {
    associatedtype Trigger
    associatedtype Effect

    associatedtype ToFeatured: Featured where ToFeatured.Trigger == Trigger, ToFeatured.Effect == Effect
    
    var machines: [ParentAutomaton<Effect, Trigger>] { get }
    
    func transit(trigger: FeatureEvent<Trigger>) -> FeatureTransition<ToFeatured>?
}
