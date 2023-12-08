//
// Created by Andriy Prokhorenko on 11.02.2023.
//

import simprokmachine

public protocol FeatureMachines: Sendable {
    associatedtype Trigger: Sendable
    associatedtype Effect: Sendable

    var machines: Set<Machine<Effect, Trigger>> { get }
}

extension FeatureMachines where Self: CustomStringConvertible, Self: CustomDebugStringConvertible {
    
    public var description: String { "machines=\(machines)" }
    
    public  var debugDescription: String { description }
}
