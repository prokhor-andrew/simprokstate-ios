//
//  Outline+ToFeatureConverter.swift
//  
//
//  Created by Andriy Prokhorenko on 19.03.2023.
//

import simprokmachine

public extension Outline {

    func asFeature(
        _ machines: Set<Machine<IntEffect, IntTrigger>>
    ) -> Feature<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        Feature(payload: payload, machines: machines) { extras, trigger in
            let transition = transit(trigger, extras.machineId, extras.logger)
            return FeatureTransition(
                transition.state.asFeature(machines),
                effects: transition.effects
            )
        }
    }
}
