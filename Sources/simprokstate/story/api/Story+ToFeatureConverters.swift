//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import simprokmachine

public extension Story {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Feature<Payload, IntTrigger, IntEffect, Event, Event> {
        asExtTriggerExtEffect().asFeature([])
    }

    func asIntEffectExtTrigger<IntTrigger, ExtEffect>(
        _ machines: Set<Machine<Event, IntTrigger>>
    ) -> Feature<Payload, IntTrigger, Event, Event, ExtEffect> {
        asIntEffectExtTrigger().asFeature(machines)
    }

    func asIntTriggerExtEffect<IntEffect, ExtTrigger>(
        _ machines: Set<Machine<IntEffect, Event>>
    ) -> Feature<Payload, Event, IntEffect, ExtTrigger, Event> {
        asIntTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect>(
        _ machines: Set<Machine<Event, Event>>
    ) -> Feature<Payload, Event, Event, ExtTrigger, ExtEffect> {
        asIntTriggerIntEffect().asFeature(machines)
    }

    func asIntEffectExtTriggerExtEffect<IntTrigger>(
        _ machines: Set<Machine<Event, IntTrigger>>
    ) -> Feature<Payload, IntTrigger, Event, Event, Event> {
        asIntEffectExtTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtEffect<ExtTrigger>(
        _ machines: Set<Machine<Event, Event>>
    ) -> Feature<Payload, Event, Event, ExtTrigger, Event> {
        asIntTriggerIntEffectExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtTrigger<ExtEffect>(
        _ machines: Set<Machine<Event, Event>>
    ) -> Feature<Payload, Event, Event, Event, ExtEffect> {
        asIntTriggerIntEffectExtTrigger().asFeature(machines)
    }

    func asIntTriggerExtTriggerExtEffect<IntEffect>(
        _ machines: Set<Machine<IntEffect, Event>>
    ) -> Feature<Payload, Event, IntEffect, Event, Event> {
        asIntTriggerExtTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtTriggerExtEffect(
        _ machines: Set<Machine<Event, Event>>
    ) -> Feature<Payload, Event, Event, Event, Event> {
        asIntTriggerIntEffectExtTriggerExtEffect().asFeature(machines)
    }
}
