//
// Created by Andriy Prokhorenko on 19.02.2023.
//


extension OutlineTransition: Equatable where IntEffect: Equatable, ExtEffect: Equatable {

    public static func ==(lhs: OutlineTransition, rhs: OutlineTransition) -> Bool {
        lhs.state == rhs.state && lhs.effects == rhs.effects
    }
}

extension OutlineTransition: Hashable where IntEffect: Hashable, ExtEffect: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(state)
        hasher.combine(effects)
    }
}
