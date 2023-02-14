//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import simprokmachine

public extension Story {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Feature<IntTrigger, IntEffect, Event, Event> {
        func feature() -> Feature<IntTrigger, IntEffect, Event, Event> {
            Feature(info: info) { _, event in
                if let new = transit(event) {
                    return FeatureTransition(
                            new.asExtTriggerExtEffect(),
                            effects: .ext(event)
                    )
                } else {
                    return FeatureTransition(feature())
                }
            }
        }

        return feature()
    }

    func asExtTriggerIntEffect<IntTrigger, ExtEffect, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<IntTrigger, Event, Event, ExtEffect> where Machines.Trigger == IntTrigger, Machines.Effect == Event {
        func feature() -> Feature<IntTrigger, Event, Event, ExtEffect> {
            Feature(machines, info: info) { machines, _, event in
                switch event {
                case .ext(let value):
                    if let new = transit(value) {
                        return FeatureTransition(
                                new.asExtTriggerIntEffect(machines),
                                effects: .int(value)
                        )
                    } else {
                        return FeatureTransition(feature())
                    }
                case .int:
                    return FeatureTransition(feature())
                }
            }
        }

        return feature()
    }

    func asIntTriggerExtEffect<IntEffect, ExtTrigger, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Event, IntEffect, ExtTrigger, Event> where Machines.Trigger == Event, Machines.Effect == IntEffect {
        func feature() -> Feature<Event, IntEffect, ExtTrigger, Event> {
            Feature(machines, info: info) { machines, _, event in
                switch event {
                case .ext:
                    return FeatureTransition(feature())
                case .int(let value):
                    if let new = transit(value) {
                        return FeatureTransition(
                                new.asIntTriggerExtEffect(machines),
                                effects: .ext(value)
                        )
                    } else {
                        return FeatureTransition(feature())
                    }
                }
            }
        }
        return feature()
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Event, Event, ExtTrigger, ExtEffect> where Machines.Trigger == Event, Machines.Effect == Event {
        func feature() -> Feature<Event, Event, ExtTrigger, ExtEffect> {
            Feature(machines, info: info) { machines, _, event in
                switch event {
                case .ext:
                    return FeatureTransition(feature())
                case .int(let value):
                    if let new = transit(value) {
                        return FeatureTransition(
                                new.asIntTriggerIntEffect(machines),
                                effects: .int(value)
                        )
                    } else {
                        return FeatureTransition(feature())
                    }
                }
            }
        }

        return feature()
    }
}