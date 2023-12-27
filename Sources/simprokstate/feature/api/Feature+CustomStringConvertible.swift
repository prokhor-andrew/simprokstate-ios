//
// Created by Andriy Prokhorenko on 14.02.2023.
//


extension Feature: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        "Feature<\(Payload.self), \(IntTrigger.self), \(IntEffect.self), \(ExtTrigger.self), \(ExtEffect.self)> payload=\(payload), machines=\(machines)"
    }
    
    public var debugDescription: String { description }
}
