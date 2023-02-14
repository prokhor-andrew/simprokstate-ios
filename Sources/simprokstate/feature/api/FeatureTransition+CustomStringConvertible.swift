//
// Created by Andriy Prokhorenko on 14.02.2023.
//


extension FeatureTransition: CustomStringConvertible {

    public var description: String {
        "Transition into " + state.description + ", with effects [" + effects.description + "]"
    }
}