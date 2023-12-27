//
// Created by Andriy Prokhorenko on 17.02.2023.
//


extension FeatureTransition: Equatable where Payload: Equatable, IntTrigger: Equatable, IntEffect: Equatable, ExtEffect: Equatable {

    public static func ==(lhs: FeatureTransition<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect>, rhs: FeatureTransition<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect>) -> Bool {
        lhs.effects == rhs.effects && lhs.state == rhs.state
    }
}

extension FeatureTransition: Hashable where Payload: Hashable, IntTrigger: Hashable, IntEffect: Hashable, ExtEffect: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(effects)
        hasher.combine(state)
    }
}
