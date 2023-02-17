//
// Created by Andriy Prokhorenko on 17.02.2023.
//


extension SceneTransition: CustomStringConvertible {

    public var description: String {
        "Transition into " + state.description + ", with effects [" + effects.description + "]"
    }
}