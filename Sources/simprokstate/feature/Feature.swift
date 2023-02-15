//
//  Feature.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import simprokmachine

public struct Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {

    public let machines: Set<Machine<IntEffect, IntTrigger>>

    private let _transit: Mapper<FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>

    public init<Machines: FeatureMachines>(
            _ machines: Machines,
            transit: @escaping BiMapper<Machines, FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>
    ) where Machines.Trigger == IntTrigger, Machines.Effect == IntEffect {
        self.machines = machines.machines
        _transit = {
            transit(machines, $0)
        }
    }

    public func transit(trigger: FeatureEvent<IntTrigger, ExtTrigger>) -> FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        _transit(trigger)
    }
}



