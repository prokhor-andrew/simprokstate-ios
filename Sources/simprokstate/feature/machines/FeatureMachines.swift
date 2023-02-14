//
// Created by Andriy Prokhorenko on 11.02.2023.
//

import simprokmachine

public protocol FeatureMachines {
    associatedtype Trigger
    associatedtype Effect

    var machines: Set<Machine<Effect, Trigger>> { get }
}


