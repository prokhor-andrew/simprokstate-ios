//
// Created by Andriy Prokhorenko on 17.02.2023.
//


extension SceneTransition: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        "Transition into " + state.description + ", with effects [" + effects.description + "]"
    }
    
    public var debugDescription: String { description }
}
