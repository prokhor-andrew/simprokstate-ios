//
//  Feature.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import simprokmachine

public struct Feature<IntTrigger: Sendable, IntEffect: Sendable, ExtTrigger: Sendable, ExtEffect: Sendable>: Identifiable, Sendable {

    public let id: String = .id
    public let machines: Set<Machine<IntEffect, IntTrigger>>
    public let transit: @Sendable (
        FeatureEvent<IntTrigger, ExtTrigger>,
        (Loggable) -> Void
    ) -> FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>

    private init(
        machines: Set<Machine<IntEffect, IntTrigger>>,
        transit: @Sendable @escaping (
            FeatureEvent<IntTrigger, ExtTrigger>,
            (Loggable) -> Void
        ) -> FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>
    ) {
        self.machines = machines
        self.transit = transit
    }

    public static func create<Machines: FeatureMachines>(
        _ machines: Machines,
        transit: @escaping (
            Machines,
            FeatureEvent<IntTrigger, ExtTrigger>,
            (Loggable) -> Void
        ) -> FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>
    ) -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> where Machines.Trigger == IntTrigger, Machines.Effect == IntEffect {
        Feature(machines: machines.machines) {
            transit(machines, $0, $1)
        }
    }
}
