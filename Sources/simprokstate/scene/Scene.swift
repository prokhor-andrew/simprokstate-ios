//
// Created by Andriy Prokhorenko on 17.02.2023.
//

public struct Scene<Trigger: Sendable, Effect: Sendable, Message>: Identifiable, Sendable {

    public let id: String = .id
    
    public let transit: @Sendable (Trigger, (Message) -> Void) -> SceneTransition<Trigger, Effect, Message>

    public init(transit: @Sendable @escaping (Trigger, (Message) -> Void) -> SceneTransition<Trigger, Effect, Message>) {
        self.transit = transit
    }
}
