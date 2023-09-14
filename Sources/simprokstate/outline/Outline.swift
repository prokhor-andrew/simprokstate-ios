//
// Created by Andriy Prokhorenko on 19.02.2023.
//


public struct Outline<IntTrigger: Sendable, IntEffect: Sendable, ExtTrigger: Sendable, ExtEffect: Sendable>: Sendable {
    
    public let id: String = .id
    
    public let transit: Optional<
        @Sendable (FeatureEvent<IntTrigger, ExtTrigger>) -> OutlineTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>?
    >

    private init(_ transit: Optional<@Sendable (FeatureEvent<IntTrigger, ExtTrigger>) -> OutlineTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>?>) {
        self.transit = transit
    }

    public static func create(
            transit: @escaping @Sendable (FeatureEvent<IntTrigger, ExtTrigger>) -> OutlineTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>?
    ) -> Outline<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        Outline(transit)
    }

    public static func finale() -> Outline<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        Outline(nil)
    }
}
