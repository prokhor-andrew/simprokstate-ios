//
// Created by Andriy Prokhorenko on 17.02.2023.
//

import simprokmachine

public extension Scene {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Feature<Payload, IntTrigger, IntEffect, Trigger, Effect, Loggable> {
        asExtTriggerExtEffect().asFeature([])
    }

    func asIntEffectExtTrigger<IntTrigger, ExtEffect>(
        _ machines: Set<Machine<Effect, IntTrigger, Loggable>>
    ) -> Feature<Payload, IntTrigger, Effect, Trigger, ExtEffect, Loggable> {
        asIntEffectExtTrigger().asFeature(machines)
    }

    func asIntTriggerExtEffect<IntEffect, ExtTrigger>(
        _ machines: Set<Machine<IntEffect, Trigger, Loggable>>
    ) -> Feature<Payload, Trigger, IntEffect, ExtTrigger, Effect, Loggable> {
        asIntTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect>(
        _ machines: Set<Machine<Effect, Trigger, Loggable>>
    ) -> Feature<Payload, Trigger, Effect, ExtTrigger, ExtEffect, Loggable> {
        asIntTriggerIntEffect().asFeature(machines)
    }

    func asIntEffectExtTriggerExtEffect<IntTrigger>(
        _ machines: Set<Machine<Effect, IntTrigger, Loggable>>
    ) -> Feature<Payload, IntTrigger, Effect, Trigger, Effect, Loggable> {
        asIntEffectExtTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtEffect<ExtTrigger>(
        _ machines: Set<Machine<Effect, Trigger, Loggable>>
    ) -> Feature<Payload, Trigger, Effect, ExtTrigger, Effect, Loggable> {
        asIntTriggerIntEffectExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtTrigger<ExtEffect>(
        _ machines: Set<Machine<Effect, Trigger, Loggable>>
    ) -> Feature<Payload, Trigger, Effect, Trigger, ExtEffect, Loggable> {
        asIntTriggerIntEffectExtTrigger().asFeature(machines)
    }

    func asIntTriggerExtTriggerExtEffect<IntEffect>(
        _ machines: Set<Machine<IntEffect, Trigger, Loggable>>
    ) -> Feature<Payload, Trigger, IntEffect, Trigger, Effect, Loggable> {
        asIntTriggerExtTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtTriggerExtEffect(
        _ machines: Set<Machine<Effect, Trigger, Loggable>>
    ) -> Feature<Payload, Trigger, Effect, Trigger, Effect, Loggable> {
        asIntTriggerIntEffectExtTriggerExtEffect().asFeature(machines)
    }
}
