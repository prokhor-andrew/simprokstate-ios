//
// Created by Andriy Prokhorenko on 17.02.2023.
//


extension SceneTransition: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        "SceneTransition<\(Payload.self), \(Trigger.self), \(Effect.self), \(Loggable.self)> state=\(state) _ effects=\(effects)"
    }
    
    public var debugDescription: String { description }
}
