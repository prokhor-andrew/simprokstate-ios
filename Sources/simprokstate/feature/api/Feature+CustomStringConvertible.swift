//
// Created by Andriy Prokhorenko on 14.02.2023.
//


extension Feature: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        "Feature id: \(id), machines [\(machines.description)]"
    }
    
    public var debugDescription: String { description }
}
