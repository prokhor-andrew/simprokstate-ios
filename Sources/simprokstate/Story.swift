//
//  Story.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import simprokmachine

public struct Story<Event> {

    private let _transit: Mapper<Event, Story<Event>?>

    public init(transit: @escaping Mapper<Event, Story<Event>?>) {
        _transit = transit
    }

    public func transit(_ event: Event) -> Story<Event>? {
        _transit(event)
    }
}

public extension Story {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Feature<IntTrigger, IntEffect, Event, Event> {
        func feature() -> Feature<IntTrigger, IntEffect, Event, Event> {
            Feature { event in
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
            Feature(machines) { machines, event in
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
            Feature(machines) { machines, event in
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
            Feature(machines) { machines, event in
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