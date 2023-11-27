//
//  Outline+ToFeatureConverter.swift
//  
//
//  Created by Andriy Prokhorenko on 19.03.2023.
//

public extension Outline {

    func asFeature<Machines: FeatureMachines>(
        _ machines: Machines
    ) -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect, Message> where Machines.Trigger == IntTrigger, Machines.Effect == IntEffect, Machines.Message == Message {
        Feature.create(machines) { machines, event, logger in
            let transition = transit(event, logger)
            return FeatureTransition(
                transition.state.asFeature(machines),
                effects: transition.effects
            )
        }
    }
}
