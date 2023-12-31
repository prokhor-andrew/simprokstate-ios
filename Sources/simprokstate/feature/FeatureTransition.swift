//
// Created by Andriy Prokhorenko on 11.02.2023.
//

public struct FeatureTransition<Payload: Sendable, IntTrigger: Sendable, IntEffect: Sendable, ExtTrigger: Sendable, ExtEffect: Sendable, Loggable: Sendable>: Sendable {

    public let state: Feature<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect, Loggable>
    public let effects: [FeatureEvent<IntEffect, ExtEffect>]

    public init(
        _ state: Feature<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect, Loggable>,
        effects: FeatureEvent<IntEffect, ExtEffect>...
    ) {
        self.init(state, effects: effects)
    }

    public init(
        _ state: Feature<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect, Loggable>,
        effects: [FeatureEvent<IntEffect, ExtEffect>]
    ) {
        self.state = state
        self.effects = effects
    }
}
