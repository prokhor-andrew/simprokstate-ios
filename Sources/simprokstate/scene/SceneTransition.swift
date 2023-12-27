//
// Created by Andriy Prokhorenko on 17.02.2023.
//


public struct SceneTransition<Payload: Sendable, Trigger: Sendable, Effect: Sendable>: Sendable {

    public let state: Scene<Payload, Trigger, Effect>
    public let effects: [Effect]

    public init(_ state: Scene<Payload, Trigger, Effect>, effects: [Effect]) {
        self.state = state
        self.effects = effects
    }

    public init(_ state: Scene<Payload, Trigger, Effect>, effects: Effect...) {
        self.init(state, effects: effects)
    }
}
