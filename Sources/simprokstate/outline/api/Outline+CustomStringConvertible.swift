//
// Created by Andriy Prokhorenko on 19.02.2023.
//


extension Outline: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        "Outline<\(Payload.self), \(IntTrigger.self), \(IntEffect.self), \(ExtTrigger.self), \(ExtEffect.self), \(Loggable.self)> payload=\(payload)"
    }
    
    public var debugDescription: String { description }
}
