//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import simprokmachine

public extension Feature {

    init<Machines: FeatureMachines>(
            _ machines: Machines,
            transit: @escaping BiMapper<Machines, FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>
    ) where Machines.Trigger == IntTrigger, Machines.Effect == IntEffect {
        self.init(machines, info: "") { machines, _, event in
            transit(machines, event)
        }
    }

    init(
            info: String,
            transit: @escaping BiMapper<String, ExtTrigger, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>
    ) {
        func feature() -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
            Feature(SetOfMachines(), info: info) { _, info, trigger in
                switch trigger {
                case .int:
                    return FeatureTransition(feature())
                case .ext(let value):
                    return transit(info, value)
                }
            }
        }

        self = feature()
    }

    init(transit: @escaping Mapper<ExtTrigger, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>) {
        func feature() -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
            Feature(SetOfMachines()) { _, trigger in
                switch trigger {
                case .int:
                    return FeatureTransition(feature())
                case .ext(let value):
                    return transit(value)
                }
            }
        }

        self = feature()
    }
}
