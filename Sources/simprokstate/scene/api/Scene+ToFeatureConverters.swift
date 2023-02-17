//
// Created by Andriy Prokhorenko on 17.02.2023.
//


public extension Scene {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Feature<IntTrigger, IntEffect, Trigger, Effect> {
        if let transit {
            return Feature.childless { event in
                if let new = transit(event) {
                    return FeatureTransition(
                            new.state.asExtTriggerExtEffect(),
                            effects: new.effects.map { .ext($0) }
                    )
                } else {
                    return nil
                }
            }
        } else {
            return .finale()
        }
    }

    func asExtTriggerIntEffect<IntTrigger, ExtEffect, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<IntTrigger, Effect, Trigger, ExtEffect> where Machines.Trigger == IntTrigger, Machines.Effect == Effect {
        if let transit {
            return Feature.create(machines) { machines, event in
                switch event {
                case .ext(let value):
                    if let new = transit(value) {
                        return FeatureTransition(
                                new.state.asExtTriggerIntEffect(machines),
                                effects: new.effects.map { .int($0) }
                        )
                    } else {
                        return nil
                    }
                case .int:
                    return nil
                }
            }
        } else {
            return .finale()
        }
    }

    func asIntTriggerExtEffect<IntEffect, ExtTrigger, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Trigger, IntEffect, ExtTrigger, Effect> where Machines.Trigger == Trigger, Machines.Effect == IntEffect {
        if let transit {
            return Feature.create(machines) { machines, event in
                switch event {
                case .ext:
                    return nil
                case .int(let value):
                    if let new = transit(value) {
                        return FeatureTransition(
                                new.state.asIntTriggerExtEffect(machines),
                                effects: new.effects.map { .ext($0) }
                        )
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return .finale()
        }
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Trigger, Effect, ExtTrigger, ExtEffect> where Machines.Trigger == Trigger, Machines.Effect == Effect {
        if let transit {
            return Feature.create(machines) { machines, event in
                switch event {
                case .ext:
                    return nil
                case .int(let value):
                    if let new = transit(value) {
                        return FeatureTransition(
                                new.state.asIntTriggerIntEffect(machines),
                                effects: new.effects.map { .int($0) }
                        )
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return .finale()
        }
    }
}