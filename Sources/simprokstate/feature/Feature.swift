//
//  Feature.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import simprokmachine

public struct Feature<IntTrigger: Sendable, IntEffect: Sendable, ExtTrigger: Sendable, ExtEffect: Sendable, Message>: Identifiable, Sendable {

    public let id: String = .id
    public let machines: Set<Machine<IntEffect, IntTrigger, Message>>
    public let transit: @Sendable (
        FeatureEvent<IntTrigger, ExtTrigger>,
        (Message) -> Void
    ) -> FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect, Message>

    private init(
        machines: Set<Machine<IntEffect, IntTrigger, Message>>,
        transit: @Sendable @escaping (
            FeatureEvent<IntTrigger, ExtTrigger>,
            (Message) -> Void
        ) -> FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect, Message>
    ) {
        self.machines = machines
        self.transit = transit
    }

    public static func create<Machines: FeatureMachines>(
        _ machines: Machines,
        transit: @escaping (
            Machines,
            FeatureEvent<IntTrigger, ExtTrigger>,
            (Message) -> Void
        ) -> FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect, Message>
    ) -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect, Message> where Machines.Trigger == IntTrigger, Machines.Effect == IntEffect, Machines.Message == Message {
        Feature(machines: machines.machines) {
            transit(machines, $0, $1)
        }
    }
}
