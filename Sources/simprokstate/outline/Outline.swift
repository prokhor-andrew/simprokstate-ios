//
// Created by Andriy Prokhorenko on 19.02.2023.
//

import simprokmachine

public struct Outline<IntTrigger: Sendable, IntEffect: Sendable, ExtTrigger: Sendable, ExtEffect: Sendable>: Identifiable, Sendable {
    
    public let id: String
    
    public let transit: @Sendable (
        FeatureEvent<IntTrigger, ExtTrigger>,
        String,
        @escaping @Sendable (Loggable) -> Void
    ) -> OutlineTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>
    

    public init(
        transit: @Sendable @escaping (
            OutlineExtras,
            FeatureEvent<IntTrigger, ExtTrigger>
        ) -> OutlineTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>
    ) {
        let id: String = .id
        self.id = id
        self.transit = {
            transit(OutlineExtras(id: id, machineId: $1, logger: $2), $0)
        }
    }
}
