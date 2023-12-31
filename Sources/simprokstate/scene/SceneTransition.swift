//
// Created by Andriy Prokhorenko on 17.02.2023.
//


public struct SceneTransition<Payload: Sendable, Trigger: Sendable, Effect: Sendable, Loggable: Sendable>: Sendable {

    public let state: Scene<Payload, Trigger, Effect, Loggable>
    public let effects: [Effect]

    public init(_ state: Scene<Payload, Trigger, Effect, Loggable>, effects: [Effect]) {
        self.state = state
        self.effects = effects
    }

    public init(_ state: Scene<Payload, Trigger, Effect, Loggable>, effects: Effect...) {
        self.init(state, effects: effects)
    }
}
