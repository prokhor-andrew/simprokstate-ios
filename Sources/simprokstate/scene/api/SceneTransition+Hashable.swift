//
// Created by Andriy Prokhorenko on 17.02.2023.
//


extension SceneTransition: Equatable where Payload: Equatable, Effect: Equatable {

    public static func ==(lhs: SceneTransition, rhs: SceneTransition) -> Bool {
        lhs.state == rhs.state && lhs.effects == rhs.effects
    }
}

extension SceneTransition: Hashable where Payload: Hashable, Effect: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(state)
        hasher.combine(effects)
    }
}
