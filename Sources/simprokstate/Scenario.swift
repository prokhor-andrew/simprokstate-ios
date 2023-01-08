//
//  Scenario.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

public protocol Scenario {
    associatedtype InternalTrigger
    associatedtype InternalEffect
    associatedtype ExternalTrigger
    associatedtype ExternalEffect

    associatedtype ToScenario: Scenario where
        ToScenario.InternalTrigger == InternalTrigger,
        ToScenario.InternalEffect == InternalEffect,
        ToScenario.ExternalTrigger == ExternalTrigger,
        ToScenario.ExternalEffect == ExternalEffect

    var effects: [ScenarioEvent<InternalEffect, ExternalEffect>] { get }

    var machines: [ParentAutomaton<InternalEffect, InternalTrigger>] { get }

    func transit(trigger: ScenarioEvent<InternalTrigger, ExternalTrigger>) -> Transition<ToScenario>
}
