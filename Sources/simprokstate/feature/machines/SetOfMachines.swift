//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import simprokmachine

public struct SetOfMachines<Trigger: Sendable, Effect: Sendable, Message>: FeatureMachines {

    public let machines: Set<Machine<Effect, Trigger, Message>>

    public init(_ machines: Set<Machine<Effect, Trigger, Message>>) {
        self.machines = machines
    }

    public init(_ machines: Machine<Effect, Trigger, Message>...) {
        self.init(Set(machines))
    }
}
