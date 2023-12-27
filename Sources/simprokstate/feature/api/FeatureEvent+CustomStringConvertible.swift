//
// Created by Andriy Prokhorenko on 14.02.2023.
//


extension FeatureEvent: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        switch self {
        case .ext(let value): "FeatureEvent<\(Internal.self), \(External.self)> ext=\(value)"
        case .int(let value): "FeatureEvent<\(Internal.self), \(External.self)> int=\(value)"
        }
    }
    
    public var debugDescription: String { description }
}
