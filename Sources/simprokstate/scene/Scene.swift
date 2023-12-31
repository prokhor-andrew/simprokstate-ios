//
// Created by Andriy Prokhorenko on 17.02.2023.
//

import simprokmachine

public struct Scene<Payload: Sendable, Trigger: Sendable, Effect: Sendable, Loggable: Sendable>: Sendable {

    public let payload: Payload
    public let transit: @Sendable (Trigger, String, MachineLogger<Loggable>) -> SceneTransition<Payload, Trigger, Effect, Loggable>

    public init(payload: Payload, transit: @Sendable @escaping (SceneExtras<Payload, Loggable>, Trigger) -> SceneTransition<Payload, Trigger, Effect, Loggable>) {
        self.payload = payload
        self.transit = { trigger, machineId, logger in
            transit(SceneExtras(payload: payload, machineId: machineId, logger: logger), trigger)
        }
    }
}
