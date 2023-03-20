//
// Created by Andriy Prokhorenko on 14.02.2023.
//

public extension Story {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Feature<IntTrigger, IntEffect, Event, Event> {
        asExtTriggerExtEffect().asFeature(SetOfMachines())
    }

    func asIntEffectExtTrigger<ExtEffect, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Machines.Trigger, Event, Event, ExtEffect> where Machines.Effect == Event {
        asIntEffectExtTrigger().asFeature(machines)
    }

    func asIntTriggerExtEffect<ExtTrigger, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Event, Machines.Effect, ExtTrigger, Event> where Machines.Trigger == Event {
        asIntTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Event, Event, ExtTrigger, ExtEffect> where Machines.Trigger == Event, Machines.Effect == Event {
        asIntTriggerIntEffect().asFeature(machines)
    }

    func asIntEffectExtTriggerExtEffect<Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Machines.Trigger, Event, Event, Event> where Machines.Effect == Event {
        asIntEffectExtTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtEffect<ExtTrigger, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Event, Event, ExtTrigger, Event> where Machines.Trigger == Event, Machines.Effect == Event {
        asIntTriggerIntEffectExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtTrigger<ExtEffect, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Event, Event, Event, ExtEffect> where Machines.Trigger == Event, Machines.Effect == Event {
        asIntTriggerIntEffectExtTrigger().asFeature(machines)
    }

    func asIntTriggerExtTriggerExtEffect<Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Event, Machines.Effect, Event, Event> where Machines.Trigger == Event, Machines.Effect == Event {
        asIntTriggerExtTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtTriggerExtEffect<Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Event, Event, Event, Event> where Machines.Trigger == Event, Machines.Effect == Event {
        asIntTriggerIntEffectExtTriggerExtEffect().asFeature(machines)
    }
}
