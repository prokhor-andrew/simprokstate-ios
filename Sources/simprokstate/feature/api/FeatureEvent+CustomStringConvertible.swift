//
// Created by Andriy Prokhorenko on 14.02.2023.
//


extension FeatureEvent: CustomStringConvertible where Internal: CustomStringConvertible, External: CustomStringConvertible {

    public var description: String {
        switch self {
        case .ext(let value):
            return "External event: " + value.description
        case .int(let value):
            return "Internal event: " + value.description
        }
    }
}