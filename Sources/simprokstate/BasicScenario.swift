//
//  BasicScenario.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

internal struct BasicScenario<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect>: Scenario {
    typealias ToScenario = BasicScenario<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect>

    let effects: [Directed<InternalEffect, ExternalEffect>]
    let machines: [ParentAutomaton<InternalEffect, InternalTrigger>]

    private let _transit: (Directed<InternalTrigger, ExternalTrigger>) -> Transition<BasicScenario<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect>>

    init(
        effects: [Directed<InternalEffect, ExternalEffect>],
        machines: [ParentAutomaton<InternalEffect, InternalTrigger>],
        transit: @escaping (Directed<InternalTrigger, ExternalTrigger>) -> Transition<BasicScenario<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect>>
    ) {
        self.effects = effects
        self.machines = machines
        self._transit = transit
    }

    func transit(trigger: Directed<InternalTrigger, ExternalTrigger>) -> Transition<BasicScenario<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect>> {
        _transit(trigger)
    }
}
