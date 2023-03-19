//
//  Outline+ToFeatureConverter.swift
//  
//
//  Created by Andriy Prokhorenko on 19.03.2023.
//

public extension Outline {

    func asFeature<Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> where Machines.Trigger == IntTrigger, Machines.Effect == IntEffect {
        if let transit {
            return Feature.create(machines) { machines, event in
                let transition = transit(event)

                return FeatureTransition(
                        transition.state.asFeature(machines),
                        effects: transition.effects
                )
            }
        } else {
            return .finale(SetOfMachines())
        }
    }
}

