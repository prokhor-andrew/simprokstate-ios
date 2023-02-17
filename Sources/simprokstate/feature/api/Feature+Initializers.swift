//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import simprokmachine

public extension Feature {

    static func finale() -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        Feature.finale(SetOfMachines())
    }

    static func childless(
            transit: @escaping Mapper<ExtTrigger, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>?>
    ) -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        Feature.create(SetOfMachines()) { _, trigger in
            switch trigger {
            case .int:
                return nil
            case .ext(let value):
                return transit(value)
            }
        }
    }

    var isChildless: Bool {
        machines.isEmpty
    }
}
