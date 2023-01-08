//
//  BasicScenario.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

internal struct BasicScenario<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect>: Scenario {
    typealias ToScenario = BasicScenario<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect>

    let effects: [ScenarioEvent<InternalEffect, ExternalEffect>]
    let machines: [ParentAutomaton<InternalEffect, InternalTrigger>]

    private let _transit: (ScenarioEvent<InternalTrigger, ExternalTrigger>) -> Transition<BasicScenario<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect>>

    init(
        effects: [ScenarioEvent<InternalEffect, ExternalEffect>],
        machines: [ParentAutomaton<InternalEffect, InternalTrigger>],
        transit: @escaping (ScenarioEvent<InternalTrigger, ExternalTrigger>) -> Transition<BasicScenario<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect>>
    ) {
        self.effects = effects
        self.machines = machines
        self._transit = transit
    }

    func transit(trigger: ScenarioEvent<InternalTrigger, ExternalTrigger>) -> Transition<BasicScenario<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect>> {
        _transit(trigger)
    }
}
