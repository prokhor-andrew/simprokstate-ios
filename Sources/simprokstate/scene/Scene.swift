//
// Created by Andriy Prokhorenko on 17.02.2023.
//

import simprokmachine

public struct Scene<Trigger: Sendable, Effect: Sendable>: Identifiable, Sendable {

    public let id: String
    
    public let transit: @Sendable (Trigger, @escaping (Loggable) -> Void) -> SceneTransition<Trigger, Effect>

    public init(transit: @Sendable @escaping (SceneExtras, Trigger) -> SceneTransition<Trigger, Effect>) {
        let id: String = .id
        self.id = id
        self.transit = {
            transit(SceneExtras(id: id, logger: $1), $0)
        }
    }
}
