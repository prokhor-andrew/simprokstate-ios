//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import simprokmachine

public extension Story {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Feature<Payload, IntTrigger, IntEffect, Event, Event, Loggable> {
        asExtTriggerExtEffect().asFeature([])
    }

    func asIntEffectExtTrigger<IntTrigger, ExtEffect>(
        _ machines: Set<Machine<Event, IntTrigger, Loggable>>
    ) -> Feature<Payload, IntTrigger, Event, Event, ExtEffect, Loggable> {
        asIntEffectExtTrigger().asFeature(machines)
    }

    func asIntTriggerExtEffect<IntEffect, ExtTrigger>(
        _ machines: Set<Machine<IntEffect, Event, Loggable>>
    ) -> Feature<Payload, Event, IntEffect, ExtTrigger, Event, Loggable> {
        asIntTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect>(
        _ machines: Set<Machine<Event, Event, Loggable>>
    ) -> Feature<Payload, Event, Event, ExtTrigger, ExtEffect, Loggable> {
        asIntTriggerIntEffect().asFeature(machines)
    }

    func asIntEffectExtTriggerExtEffect<IntTrigger>(
        _ machines: Set<Machine<Event, IntTrigger, Loggable>>
    ) -> Feature<Payload, IntTrigger, Event, Event, Event, Loggable> {
        asIntEffectExtTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtEffect<ExtTrigger>(
        _ machines: Set<Machine<Event, Event, Loggable>>
    ) -> Feature<Payload, Event, Event, ExtTrigger, Event, Loggable> {
        asIntTriggerIntEffectExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtTrigger<ExtEffect>(
        _ machines: Set<Machine<Event, Event, Loggable>>
    ) -> Feature<Payload, Event, Event, Event, ExtEffect, Loggable> {
        asIntTriggerIntEffectExtTrigger().asFeature(machines)
    }

    func asIntTriggerExtTriggerExtEffect<IntEffect>(
        _ machines: Set<Machine<IntEffect, Event, Loggable>>
    ) -> Feature<Payload, Event, IntEffect, Event, Event, Loggable> {
        asIntTriggerExtTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtTriggerExtEffect(
        _ machines: Set<Machine<Event, Event, Loggable>>
    ) -> Feature<Payload, Event, Event, Event, Event, Loggable> {
        asIntTriggerIntEffectExtTriggerExtEffect().asFeature(machines)
    }
}
