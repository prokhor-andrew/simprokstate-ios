//
//  Feature.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import Foundation
import simprokmachine

public struct Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {

    public let id = UUID()
    public let machines: Set<Machine<IntEffect, IntTrigger>>
    public let transit: Mapper<FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>?

    private init(
            machines: Set<Machine<IntEffect, IntTrigger>>,
            transit: Mapper<FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>?
    ) {
        self.machines = machines
        self.transit = transit
    }

    public static func finale<Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> where Machines.Trigger == IntTrigger, Machines.Effect == IntEffect {
        Feature(machines: machines.machines, transit: nil)
    }

    public static func create<Machines: FeatureMachines>(
            _ machines: Machines,
            transit: @escaping BiMapper<Machines, FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>
    ) -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> where Machines.Trigger == IntTrigger, Machines.Effect == IntEffect {
        Feature(machines: machines.machines) {
            transit(machines, $0)
        }
    }
}