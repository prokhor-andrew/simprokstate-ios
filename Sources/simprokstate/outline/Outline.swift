//
// Created by Andriy Prokhorenko on 19.02.2023.
//

import simprokmachine

public struct Outline<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
    
    public let id: String = .id
    
    public let transit: Optional<
        (FeatureEvent<IntTrigger, ExtTrigger>) -> OutlineTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>?
    >

    private init(_ transit: Optional<(FeatureEvent<IntTrigger, ExtTrigger>) -> OutlineTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>?>) {
        self.transit = transit
    }

    public static func create(
            transit: @escaping (FeatureEvent<IntTrigger, ExtTrigger>) -> OutlineTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>?
    ) -> Outline<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        Outline(transit)
    }

    public static func finale() -> Outline<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        Outline(nil)
    }
}
