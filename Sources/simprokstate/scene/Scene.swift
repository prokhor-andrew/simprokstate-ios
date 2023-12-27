//
// Created by Andriy Prokhorenko on 17.02.2023.
//

import simprokmachine

public struct Scene<Payload: Sendable, Trigger: Sendable, Effect: Sendable>: Sendable {

    public let payload: Payload
    public let transit: @Sendable (Trigger, String, MachineLogger) -> SceneTransition<Payload, Trigger, Effect>

    public init(payload: Payload, transit: @Sendable @escaping (SceneExtras<Payload>, Trigger) -> SceneTransition<Payload, Trigger, Effect>) {
        self.payload = payload
        self.transit = { trigger, machineId, logger in
            transit(SceneExtras(payload: payload, machineId: machineId, logger: logger), trigger)
        }
    }
}
