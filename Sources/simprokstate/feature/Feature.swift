//
//  Feature.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import simprokmachine

public struct Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {

    public let machines: Set<Machine<IntEffect, IntTrigger>>
    public let info: String

    private let _transit: Mapper<FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>

    public init<Machines: FeatureMachines>(
            _ machines: Machines,
            info: String,
            transit: @escaping TriMapper<Machines, String, FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>
    ) where Machines.Trigger == IntTrigger, Machines.Effect == IntEffect {
        self.machines = machines.machines
        self.info = info
        _transit = {
            transit(machines, info, $0)
        }
    }

    public func transit(trigger: FeatureEvent<IntTrigger, ExtTrigger>) -> FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        _transit(trigger)
    }
}



