//
// Created by Andriy Prokhorenko on 14.02.2023.
//


extension FeatureTransition: CustomStringConvertible, CustomDebugStringConvertible {

    public var debugDescription: String { description }
    
    public var description: String {
        "Transition into " + state.description + ", with effects [" + effects.description + "]"
    }
}
