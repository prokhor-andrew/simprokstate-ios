//
// Created by Andriy Prokhorenko on 14.02.2023.
//


extension FeatureTransition: CustomStringConvertible, CustomDebugStringConvertible {

    public var debugDescription: String { description }
    
    public var description: String {
        "FeatureTransition<\(Payload.self), \(IntTrigger.self), \(IntEffect.self), \(ExtTrigger.self), \(ExtEffect.self)>  state=\(state) _ effects=\(effects)"
    }
}
