//
// Created by Andriy Prokhorenko on 11.02.2023.
//

import simprokmachine

public protocol FeatureMachines {
    associatedtype Trigger
    associatedtype Effect

    var machines: Set<Machine<Effect, Trigger>> { get }
}


public struct EmptyMachines<Trigger, Effect>: FeatureMachines {

    public let machines: Set<Machine<Effect, Trigger>> = []

    public init() {

    }
}

public struct SetOfMachines<Trigger, Effect>: FeatureMachines {

    public let machines: Set<Machine<Effect, Trigger>>

    public init(_ machines: Set<Machine<Effect, Trigger>>) {
        self.machines = machines
    }
}