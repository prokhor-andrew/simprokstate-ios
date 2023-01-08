//
//  Featured.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

public protocol Featured {
    associatedtype InternalTrigger
    associatedtype InternalEffect
    associatedtype ExternalTrigger
    associatedtype ExternalEffect

    associatedtype ToFeatured: Featured where
    ToFeatured.InternalTrigger == InternalTrigger,
    ToFeatured.InternalEffect == InternalEffect,
    ToFeatured.ExternalTrigger == ExternalTrigger,
    ToFeatured.ExternalEffect == ExternalEffect
    
    var machines: [ParentAutomaton<InternalEffect, InternalTrigger>] { get }

    func effects() -> [FeatureEvent<InternalEffect, ExternalEffect>]
    
    func transit(trigger: FeatureEvent<InternalTrigger, ExternalTrigger>) -> FeatureTransition<ToFeatured>
}
