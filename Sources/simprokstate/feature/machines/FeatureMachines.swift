//
// Created by Andriy Prokhorenko on 11.02.2023.
//

import simprokmachine

public protocol FeatureMachines: Sendable {
    associatedtype Trigger: Sendable
    associatedtype Effect: Sendable

    var machines: Set<Machine<Effect, Trigger>> { get }
}

