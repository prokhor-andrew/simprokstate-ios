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

public func ExtTriggerExtEffect<Event, IntTrigger, IntEffect>(
        _ story: Story<Event>
) -> Feature<IntTrigger, IntEffect, Event, Event> {
    Feature { event in
        if let new = story.transit(event) {
            return Feature.Transition(
                    ExtTriggerExtEffect(new),
                    effects: .ext(event)
            )
        } else {
            return nil
        }
    }
}

public func ExtTriggerIntEffect<Event, IntTrigger, ExtEffect>(
        _ story: Story<Event>,
        machines: [Machine<Event, IntTrigger>]
) -> Feature<IntTrigger, Event, Event, ExtEffect> {
    Feature(machines: machines) { machines, event in
        switch event {
        case .ext(let value):
            if let new = story.transit(value) {
                return Feature.Transition(
                        ExtTriggerIntEffect(new, machines: machines),
                        effects: .int(value)
                )
            } else {
                return nil
            }
        case .int:
            return nil
        }
    }
}

public func IntTriggerExtEffect<Event, IntEffect, ExtTrigger>(
        _ story: Story<Event>,
        machines: [Machine<IntEffect, Event>]
) -> Feature<Event, IntEffect, ExtTrigger, Event> {
    Feature(machines: machines) { machines, event in
        switch event {
        case .ext:
            return nil
        case .int(let value):
            if let new = story.transit(value) {
                return Feature.Transition(
                        IntTriggerExtEffect(new, machines: machines),
                        effects: .ext(value)
                )
            } else {
                return nil
            }
        }
    }
}

public func IntTriggerIntEffect<Event, ExtTrigger, ExtEffect>(
        _ story: Story<Event>,
        machines: [Machine<Event, Event>]
) -> Feature<Event, Event, ExtTrigger, ExtEffect> {
    Feature(machines: machines) { machines, event in
        switch event {
        case .ext:
            return nil
        case .int(let value):
            if let new = story.transit(value) {
                return Feature.Transition(
                        IntTriggerIntEffect(new, machines: machines),
                        effects: .int(value)
                )
            } else {
                return nil
            }
        }
    }
}