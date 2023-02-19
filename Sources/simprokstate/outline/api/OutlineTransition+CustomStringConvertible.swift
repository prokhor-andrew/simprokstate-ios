//
// Created by Andriy Prokhorenko on 19.02.2023.
//

extension OutlineTransition: CustomStringConvertible {

    public var description: String {
        "Transition into " + state.description + ", with effects [" + effects.description + "]"
    }
}