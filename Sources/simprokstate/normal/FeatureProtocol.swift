//
//  FeatureProtocol.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

public protocol FeatureProtocol {
    associatedtype InternalTrigger
    associatedtype InternalEffect
    associatedtype ExternalTrigger
    associatedtype ExternalEffect

    associatedtype ToFeature: FeatureProtocol where
    ToFeature.InternalTrigger == InternalTrigger,
    ToFeature.InternalEffect == InternalEffect,
    ToFeature.ExternalTrigger == ExternalTrigger,
    ToFeature.ExternalEffect == ExternalEffect
    
    var machines: Machines<InternalEffect, InternalTrigger> { get }
    
    func transit(trigger: FeatureEvent<InternalTrigger, ExternalTrigger>) -> FeatureTransition<ToFeature>?
}
