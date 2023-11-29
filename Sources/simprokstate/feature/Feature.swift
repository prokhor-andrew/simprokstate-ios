//
//  Feature.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import simprokmachine

public struct Feature<IntTrigger: Sendable, IntEffect: Sendable, ExtTrigger: Sendable, ExtEffect: Sendable>: Identifiable, Sendable {

    public let id: String
    public let machines: Set<Machine<IntEffect, IntTrigger>>
    public let transit: @Sendable (
        FeatureEvent<IntTrigger, ExtTrigger>,
        @escaping (Loggable) -> Void
    ) -> FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>

    private init(
        id: String,
        machines: Set<Machine<IntEffect, IntTrigger>>,
        transit: @Sendable @escaping (
            FeatureEvent<IntTrigger, ExtTrigger>,
            @escaping (Loggable) -> Void
        ) -> FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>
    ) {
        self.id = id
        self.machines = machines
        self.transit = transit
    }

    public static func create<Machines: FeatureMachines>(
        _ machines: Machines,
        transit: @escaping (
            FeatureExtras<Machines>,
            FeatureEvent<IntTrigger, ExtTrigger>
        ) -> FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>
    ) -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> where Machines.Trigger == IntTrigger, Machines.Effect == IntEffect {
        let id: String = .id
        return Feature(id: id, machines: machines.machines) { trigger, logger in
            transit(FeatureExtras(id: id, machines: machines, logger: logger), trigger)
        }
    }
}
