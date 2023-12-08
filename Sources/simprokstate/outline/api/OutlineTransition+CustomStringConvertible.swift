//
// Created by Andriy Prokhorenko on 19.02.2023.
//

extension OutlineTransition: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        "Transition into " + state.description + ", with effects [" + effects.description + "]"
    }
    
    public var debugDescription: String { description }
}
