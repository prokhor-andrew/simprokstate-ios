//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import simprokmachine

public struct SetOfMachines<Trigger, Effect>: FeatureMachines {

    public let machines: Set<Machine<Effect, Trigger>>

    public init(_ machines: Set<Machine<Effect, Trigger>>) {
        self.machines = machines
    }

    public init(_ machines: Machine<Effect, Trigger>...) {
        self.init(Set(machines))
    }
}