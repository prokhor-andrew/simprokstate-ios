//
// Created by Andriy Prokhorenko on 17.02.2023.
//


public extension Scene {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Feature<IntTrigger, IntEffect, Trigger, Effect> {
        if let transit {
            let feature: Feature<IntTrigger, IntEffect, Trigger, Effect> = Feature.create(SetOfMachines()) { _, event in
                switch event {
                case .ext(let value):
                    let new = transit(value)
                    return FeatureTransition(
                            new.state.asExtTriggerExtEffect(),
                            effects: new.effects.map {
                                .ext($0)
                            }
                    )
                case .int:
                    return FeatureTransition(feature)
                }
            }

            return feature
        } else {
            return .finale(SetOfMachines())
        }
    }

    func asExtTriggerIntEffect<IntTrigger, ExtEffect, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<IntTrigger, Effect, Trigger, ExtEffect> where Machines.Trigger == IntTrigger, Machines.Effect == Effect {
        if let transit {
            let feature: Feature<IntTrigger, Effect, Trigger, ExtEffect> = Feature.create(machines) { machines, event in
                switch event {
                case .ext(let value):
                    let new = transit(value)
                    return FeatureTransition(
                            new.state.asExtTriggerIntEffect(machines),
                            effects: new.effects.map {
                                .int($0)
                            }
                    )
                case .int:
                    return FeatureTransition(feature)
                }
            }
            return feature
        } else {
            return .finale(SetOfMachines())
        }
    }

    func asIntTriggerExtEffect<IntEffect, ExtTrigger, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Trigger, IntEffect, ExtTrigger, Effect> where Machines.Trigger == Trigger, Machines.Effect == IntEffect {
        if let transit {
            let feature: Feature<Trigger, IntEffect, ExtTrigger, Effect> = Feature.create(machines) { machines, event in
                switch event {
                case .ext:
                    return FeatureTransition(feature)
                case .int(let value):
                    let new = transit(value)
                    return FeatureTransition(
                            new.state.asIntTriggerExtEffect(machines),
                            effects: new.effects.map {
                                .ext($0)
                            }
                    )

                }
            }

            return feature
        } else {
            return .finale(SetOfMachines())
        }
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Trigger, Effect, ExtTrigger, ExtEffect> where Machines.Trigger == Trigger, Machines.Effect == Effect {
        if let transit {
            let feature: Feature<Trigger, Effect, ExtTrigger, ExtEffect> = Feature.create(machines) { machines, event in
                switch event {
                case .ext:
                    return FeatureTransition(feature)
                case .int(let value):
                    let new = transit(value)
                    return FeatureTransition(
                            new.state.asIntTriggerIntEffect(machines),
                            effects: new.effects.map {
                                .int($0)
                            }
                    )
                }
            }

            return feature
        } else {
            return .finale(SetOfMachines())
        }
    }
}