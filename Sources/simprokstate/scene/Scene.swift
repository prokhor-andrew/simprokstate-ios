//
// Created by Andriy Prokhorenko on 17.02.2023.
//

import simprokmachine

public struct Scene<Trigger: Sendable, Effect: Sendable>: Identifiable, Sendable {

    public let id: String = .id
    
    public let transit: @Sendable (Trigger, (Loggable) -> Void) -> SceneTransition<Trigger, Effect>

    public init(transit: @Sendable @escaping (Trigger, (Loggable) -> Void) -> SceneTransition<Trigger, Effect>) {
        self.transit = transit
    }
}
