//
// Created by Andriy Prokhorenko on 19.02.2023.
//


public struct OutlineTransition<Payload: Sendable, IntTrigger: Sendable, IntEffect: Sendable, ExtTrigger: Sendable, ExtEffect: Sendable, Loggable: Sendable>: Sendable {

    public let state: Outline<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect, Loggable>
    public let effects: [FeatureEvent<IntEffect, ExtEffect>]

    public init(_ state: Outline<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect, Loggable>, effects: [FeatureEvent<IntEffect, ExtEffect>]) {
        self.state = state
        self.effects = effects
    }

    public init(_ state: Outline<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect, Loggable>, effects: FeatureEvent<IntEffect, ExtEffect>...) {
        self.init(state, effects: effects)
    }
}
