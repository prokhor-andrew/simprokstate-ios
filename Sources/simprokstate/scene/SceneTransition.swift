//
// Created by Andriy Prokhorenko on 17.02.2023.
//


public struct SceneTransition<Trigger, Effect> {

    public let state: Scene<Trigger, Effect>
    public let effects: [Effect]

    public init(_ state: Scene<Trigger, Effect>, effects: [Effect]) {
        self.state = state
        self.effects = effects
    }

    public init(_ state: Scene<Trigger, Effect>, effects: Effect...) {
        self.init(state, effects: effects)
    }
}
