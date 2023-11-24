//
// Created by Andriy Prokhorenko on 19.02.2023.
//


public struct Outline<IntTrigger: Sendable, IntEffect: Sendable, ExtTrigger: Sendable, ExtEffect: Sendable>: Identifiable, Sendable {
    
    public let id: String = .id
    
    public let transit: @Sendable (FeatureEvent<IntTrigger, ExtTrigger>) -> OutlineTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>
    

    public init(transit: @Sendable @escaping (FeatureEvent<IntTrigger, ExtTrigger>) -> OutlineTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>) {
        self.transit = transit
    }
}
