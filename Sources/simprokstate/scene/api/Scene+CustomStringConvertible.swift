//
// Created by Andriy Prokhorenko on 17.02.2023.
//


extension Scene: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        "Scene<\(Payload.self), \(Trigger.self), \(Effect.self), \(Loggable.self)> payload=\(payload)"
    }
    
    public var debugDescription: String { description }
}
