//
// Created by Andriy Prokhorenko on 17.02.2023.
//

public struct Scene<Trigger: Sendable, Effect: Sendable>: Identifiable, Sendable {

    public let id: String = .id
    
    public let transit: @Sendable (Trigger, (String) -> Void) -> SceneTransition<Trigger, Effect>

    public init(transit: @Sendable @escaping (Trigger, (String) -> Void) -> SceneTransition<Trigger, Effect>) {
        self.transit = transit
    }
}
