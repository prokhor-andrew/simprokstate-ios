//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import simprokmachine

public extension Story {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Feature<IntTrigger, IntEffect, Event, Event> {
        if let transit {
            return Feature.childless { event in
                if let new = transit(event) {
                    return FeatureTransition(
                            new.asExtTriggerExtEffect(),
                            effects: .ext(event)
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
    ) -> Feature<IntTrigger, Event, Event, ExtEffect> where Machines.Trigger == IntTrigger, Machines.Effect == Event {
        if let transit {
            return Feature.create(machines) { machines, event in
                switch event {
                case .ext(let value):
                    if let new = transit(value) {
                        return FeatureTransition(
                                new.asExtTriggerIntEffect(machines),
                                effects: .int(value)
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
    ) -> Feature<Event, IntEffect, ExtTrigger, Event> where Machines.Trigger == Event, Machines.Effect == IntEffect {
        if let transit {
            return Feature.create(machines) { machines, event in
                switch event {
                case .ext:
                    return nil
                case .int(let value):
                    if let new = transit(value) {
                        return FeatureTransition(
                                new.asIntTriggerExtEffect(machines),
                                effects: .ext(value)
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
    ) -> Feature<Event, Event, ExtTrigger, ExtEffect> where Machines.Trigger == Event, Machines.Effect == Event {
        if let transit {
            return Feature.create(machines) { machines, event in
                switch event {
                case .ext:
                    return nil
                case .int(let value):
                    if let new = transit(value) {
                        return FeatureTransition(
                                new.asIntTriggerIntEffect(machines),
                                effects: .int(value)
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