//
// Created by Andriy Prokhorenko on 17.02.2023.
//


extension FeatureTransition: Equatable where IntTrigger: Equatable, IntEffect: Equatable, ExtEffect: Equatable {

    public static func ==(lhs: FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect, Message>, rhs: FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect, Message>) -> Bool {
        lhs.effects == rhs.effects && lhs.state == rhs.state
    }
}

extension FeatureTransition: Hashable where IntTrigger: Hashable, IntEffect: Hashable, ExtEffect: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(effects)
        hasher.combine(state)
    }
}
