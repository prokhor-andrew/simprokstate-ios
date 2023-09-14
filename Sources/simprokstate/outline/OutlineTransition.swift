//
// Created by Andriy Prokhorenko on 19.02.2023.
//


public struct OutlineTransition<IntTrigger: Sendable, IntEffect: Sendable, ExtTrigger: Sendable, ExtEffect: Sendable>: Sendable {

    public let state: Outline<IntTrigger, IntEffect, ExtTrigger, ExtEffect>
    public let effects: [FeatureEvent<IntEffect, ExtEffect>]

    public init(_ state: Outline<IntTrigger, IntEffect, ExtTrigger, ExtEffect>, effects: [FeatureEvent<IntEffect, ExtEffect>]) {
        self.state = state
        self.effects = effects
    }

    public init(_ state: Outline<IntTrigger, IntEffect, ExtTrigger, ExtEffect>, effects: FeatureEvent<IntEffect, ExtEffect>...) {
        self.init(state, effects: effects)
    }
}
