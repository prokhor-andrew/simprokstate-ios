//
// Created by Andriy Prokhorenko on 17.02.2023.
//


public struct SceneTransition<Trigger: Sendable, Effect: Sendable, Message>: Sendable {

    public let state: Scene<Trigger, Effect, Message>
    public let effects: [Effect]

    public init(_ state: Scene<Trigger, Effect, Message>, effects: [Effect]) {
        self.state = state
        self.effects = effects
    }

    public init(_ state: Scene<Trigger, Effect, Message>, effects: Effect...) {
        self.init(state, effects: effects)
    }
}
