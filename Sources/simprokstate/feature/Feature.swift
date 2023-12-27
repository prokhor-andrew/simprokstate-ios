//
//  Feature.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import simprokmachine

public struct Feature<Payload: Sendable, IntTrigger: Sendable, IntEffect: Sendable, ExtTrigger: Sendable, ExtEffect: Sendable>: Sendable {

    public let payload: Payload
    public let machines: Set<Machine<IntEffect, IntTrigger>>
    public let transit: @Sendable (
        FeatureEvent<IntTrigger, ExtTrigger>,
        String,
        MachineLogger
    ) -> FeatureTransition<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect>

    private init(
        payload: Payload,
        machines: Set<Machine<IntEffect, IntTrigger>>,
        transit: @Sendable @escaping (
            FeatureEvent<IntTrigger, ExtTrigger>,
            String,
            MachineLogger
        ) -> FeatureTransition<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect>
    ) {
        self.payload = payload
        self.machines = machines
        self.transit = transit
    }

    public init(
        payload: Payload,
        machines: Set<Machine<IntEffect, IntTrigger>>,
        transit: @escaping (
            FeatureExtras<Payload, IntTrigger, IntEffect>,
            FeatureEvent<IntTrigger, ExtTrigger>
        ) -> FeatureTransition<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect>
    ) {
        self.init(payload: payload, machines: machines) { trigger, machineId, logger in
            transit(FeatureExtras(payload: payload, machineId: machineId, machines: machines, logger: logger), trigger)
        }
    }
}
