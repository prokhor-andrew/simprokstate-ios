//
// Created by Andriy Prokhorenko on 17.02.2023.
//

import simprokmachine

public extension Scene {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Feature<Payload, IntTrigger, IntEffect, Trigger, Effect> {
        asExtTriggerExtEffect().asFeature([])
    }

    func asIntEffectExtTrigger<IntTrigger, ExtEffect>(
        _ machines: Set<Machine<Effect, IntTrigger>>
    ) -> Feature<Payload, IntTrigger, Effect, Trigger, ExtEffect> {
        asIntEffectExtTrigger().asFeature(machines)
    }

    func asIntTriggerExtEffect<IntEffect, ExtTrigger>(
        _ machines: Set<Machine<IntEffect, Trigger>>
    ) -> Feature<Payload, Trigger, IntEffect, ExtTrigger, Effect> {
        asIntTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect>(
        _ machines: Set<Machine<Effect, Trigger>>
    ) -> Feature<Payload, Trigger, Effect, ExtTrigger, ExtEffect> {
        asIntTriggerIntEffect().asFeature(machines)
    }

    func asIntEffectExtTriggerExtEffect<IntTrigger>(
        _ machines: Set<Machine<Effect, IntTrigger>>
    ) -> Feature<Payload, IntTrigger, Effect, Trigger, Effect> {
        asIntEffectExtTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtEffect<ExtTrigger>(
        _ machines: Set<Machine<Effect, Trigger>>
    ) -> Feature<Payload, Trigger, Effect, ExtTrigger, Effect> {
        asIntTriggerIntEffectExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtTrigger<ExtEffect>(
        _ machines: Set<Machine<Effect, Trigger>>
    ) -> Feature<Payload, Trigger, Effect, Trigger, ExtEffect> {
        asIntTriggerIntEffectExtTrigger().asFeature(machines)
    }

    func asIntTriggerExtTriggerExtEffect<IntEffect>(
        _ machines: Set<Machine<IntEffect, Trigger>>
    ) -> Feature<Payload, Trigger, IntEffect, Trigger, Effect> {
        asIntTriggerExtTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtTriggerExtEffect(
        _ machines: Set<Machine<Effect, Trigger>>
    ) -> Feature<Payload, Trigger, Effect, Trigger, Effect> {
        asIntTriggerIntEffectExtTriggerExtEffect().asFeature(machines)
    }
}
