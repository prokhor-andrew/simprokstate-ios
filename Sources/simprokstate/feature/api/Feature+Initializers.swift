//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import simprokmachine

public extension Feature {

    static func childless(
            transit: @escaping Mapper<ExtTrigger, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>
    ) -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        func feature() -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
            Feature.create(SetOfMachines()) { _, trigger in
                switch trigger {
                case .int:
                    return FeatureTransition(feature())
                case .ext(let value):
                    return transit(value)
                }
            }
        }

        return feature()
    }
}
