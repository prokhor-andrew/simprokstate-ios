//
// Created by Andriy Prokhorenko on 11.02.2023.
//

public struct FeatureTransition<IntTrigger: Sendable, IntEffect: Sendable, ExtTrigger: Sendable, ExtEffect: Sendable, Message>: Sendable {

    public let state: Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect, Message>
    public let effects: [FeatureEvent<IntEffect, ExtEffect>]

    public init(
        _ state: Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect, Message>,
        effects: FeatureEvent<IntEffect, ExtEffect>...
    ) {
        self.init(state, effects: effects)
    }

    public init(
        _ state: Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect, Message>,
        effects: [FeatureEvent<IntEffect, ExtEffect>]
    ) {
        self.state = state
        self.effects = effects
    }
}
