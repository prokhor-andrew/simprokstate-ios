//
// Created by Andriy Prokhorenko on 14.02.2023.
//


extension FeatureEvent: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        switch self {
        case .ext(let value):
            return "External event: \(value)"
        case .int(let value):
            return "Internal event: \(value)"
        }
    }
    
    public var debugDescription: String { description }
}
