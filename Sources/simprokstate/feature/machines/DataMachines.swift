//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import simprokmachine

public struct DataMachines<Data: Sendable, Trigger: Sendable, Effect: Sendable, Message>: FeatureMachines {

    public let data: Data
    public let machines: Set<Machine<Effect, Trigger, Message>>

    public init(_ data: Data, machines: Set<Machine<Effect, Trigger, Message>>) {
        self.data = data
        self.machines = machines
    }

    public init(_ data: Data, machines: Machine<Effect, Trigger, Message>...) {
        self.init(data, machines: Set(machines))
    }
}
