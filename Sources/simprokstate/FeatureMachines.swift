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

public extension Feature {

    init(
            _ machines: Set<Machine<IntEffect, IntTrigger>>,
            transit: @escaping BiMapper<Set<Machine<IntEffect, IntTrigger>>, FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>
    ) {
        self.init(SetOfMachines(machines)) { machines, event in
            transit(machines.machines, event)
        }
    }

    init(
            _ machines: Machine<IntEffect, IntTrigger>...,
            transit: @escaping BiMapper<Set<Machine<IntEffect, IntTrigger>>, FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>
    ) {
        self.init(Set(machines), transit: transit)
    }
}

public struct SetOfMachines<Trigger, Effect>: FeatureMachines {

    public let machines: Set<Machine<Effect, Trigger>>

    public init(_ machines: Set<Machine<Effect, Trigger>>) {
        self.machines = machines
    }

    public init(_ machines: Machine<Effect, Trigger>...) {
        self.init(Set(machines))
    }
}