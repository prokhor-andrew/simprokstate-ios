//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import simprokmachine

public extension Story {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Feature<IntTrigger, IntEffect, Event, Event> {
        if let transit {
            let feature: Feature<IntTrigger, IntEffect, Event, Event> = Feature.create(SetOfMachines()) { _, event in
                switch event {
                case .ext(let value):
                    if let new = transit(value) {
                        return FeatureTransition(
                                new.asExtTriggerExtEffect(),
                                effects: .ext(value)
                        )
                    } else {
                        return FeatureTransition(feature)
                    }
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
    ) -> Feature<IntTrigger, Event, Event, ExtEffect> where Machines.Trigger == IntTrigger, Machines.Effect == Event {
        if let transit {
            let feature: Feature<IntTrigger, Event, Event, ExtEffect> = Feature.create(machines) { machines, event in
                switch event {
                case .ext(let value):
                    if let new = transit(value) {
                        return FeatureTransition(
                                new.asExtTriggerIntEffect(machines),
                                effects: .int(value)
                        )
                    } else {
                        return FeatureTransition(feature)
                    }
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
    ) -> Feature<Event, IntEffect, ExtTrigger, Event> where Machines.Trigger == Event, Machines.Effect == IntEffect {
        if let transit {
            let feature: Feature<Event, IntEffect, ExtTrigger, Event> = Feature.create(machines) { machines, event in
                switch event {
                case .ext:
                    return FeatureTransition(feature)
                case .int(let value):
                    if let new = transit(value) {
                        return FeatureTransition(
                                new.asIntTriggerExtEffect(machines),
                                effects: .ext(value)
                        )
                    } else {
                        return FeatureTransition(feature)
                    }
                }
            }

            return feature
        } else {
            return .finale(SetOfMachines())
        }
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Event, Event, ExtTrigger, ExtEffect> where Machines.Trigger == Event, Machines.Effect == Event {
        if let transit {
            let feature: Feature<Event, Event, ExtTrigger, ExtEffect> = Feature.create(machines) { machines, event in
                switch event {
                case .ext:
                    return FeatureTransition(feature)
                case .int(let value):
                    if let new = transit(value) {
                        return FeatureTransition(
                                new.asIntTriggerIntEffect(machines),
                                effects: .int(value)
                        )
                    } else {
                        return FeatureTransition(feature)
                    }
                }
            }

            return feature
        } else {
            return .finale(SetOfMachines())
        }
    }
}