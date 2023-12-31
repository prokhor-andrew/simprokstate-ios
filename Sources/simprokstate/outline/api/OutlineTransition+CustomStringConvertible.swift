//
// Created by Andriy Prokhorenko on 19.02.2023.
//

extension OutlineTransition: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        "OutlineTransition<\(Payload.self), \(IntTrigger.self), \(IntEffect.self), \(ExtTrigger.self), \(ExtEffect.self), \(Loggable.self)> state=\(state) _ effects=\(effects)"
    }
    
    public var debugDescription: String { description }
}
