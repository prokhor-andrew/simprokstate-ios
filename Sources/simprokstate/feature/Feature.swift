//
//  Feature.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import simprokmachine

public struct Feature<Payload: Sendable, IntTrigger: Sendable, IntEffect: Sendable, ExtTrigger: Sendable, ExtEffect: Sendable, Loggable: Sendable>: Sendable {

    public let payload: Payload
    public let machines: Set<Machine<IntEffect, IntTrigger, Loggable>>
    public let transit: @Sendable (
        FeatureEvent<IntTrigger, ExtTrigger>,
        String,
        MachineLogger<Loggable>
    ) -> FeatureTransition<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect, Loggable>

    private init(
        payload: Payload,
        machines: Set<Machine<IntEffect, IntTrigger, Loggable>>,
        transit: @Sendable @escaping (
            FeatureEvent<IntTrigger, ExtTrigger>,
            String,
            MachineLogger<Loggable>
        ) -> FeatureTransition<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect, Loggable>
    ) {
        self.payload = payload
        self.machines = machines
        self.transit = transit
    }

    public init(
        payload: Payload,
        machines: Set<Machine<IntEffect, IntTrigger, Loggable>>,
        transit: @escaping (
            FeatureExtras<Payload, IntTrigger, IntEffect, Loggable>,
            FeatureEvent<IntTrigger, ExtTrigger>
        ) -> FeatureTransition<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect, Loggable>
    ) {
        self.init(payload: payload, machines: machines) { trigger, machineId, logger in
            transit(FeatureExtras(payload: payload, machineId: machineId, machines: machines, logger: logger), trigger)
        }
    }
}
