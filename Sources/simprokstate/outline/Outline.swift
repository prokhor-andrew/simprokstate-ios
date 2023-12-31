//
// Created by Andriy Prokhorenko on 19.02.2023.
//

import simprokmachine

public struct Outline<Payload: Sendable, IntTrigger: Sendable, IntEffect: Sendable, ExtTrigger: Sendable, ExtEffect: Sendable, Loggable: Sendable>: Sendable {
    
    public let payload: Payload
    public let transit: @Sendable (
        FeatureEvent<IntTrigger, ExtTrigger>,
        String,
        MachineLogger<Loggable>
    ) -> OutlineTransition<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect, Loggable>
    

    public init(
        payload: Payload,
        transit: @Sendable @escaping (
            OutlineExtras<Payload, Loggable>,
            FeatureEvent<IntTrigger, ExtTrigger>
        ) -> OutlineTransition<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect, Loggable>
    ) {
        self.payload = payload
        self.transit = { trigger, machineId, logger in
            transit(OutlineExtras(payload: payload, machineId: machineId, logger: logger), trigger)
        }
    }
}
