//
// Created by Andriy Prokhorenko on 19.02.2023.
//


public struct Outline<IntTrigger: Sendable, IntEffect: Sendable, ExtTrigger: Sendable, ExtEffect: Sendable, Message>: Identifiable, Sendable {
    
    public let id: String = .id
    
    public let transit: @Sendable (
        FeatureEvent<IntTrigger, ExtTrigger>,
        (Message) -> Void
    ) -> OutlineTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect, Message>
    

    public init(
        transit: @Sendable @escaping (
            FeatureEvent<IntTrigger, ExtTrigger>,
            (Message) -> Void
        ) -> OutlineTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect, Message>
    ) {
        self.transit = transit
    }
}
