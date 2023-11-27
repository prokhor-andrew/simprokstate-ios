//
// Created by Andriy Prokhorenko on 14.02.2023.
//

public extension Story {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Feature<IntTrigger, IntEffect, Event, Event, Message> {
        asExtTriggerExtEffect().asFeature(SetOfMachines())
    }

    func asIntEffectExtTrigger<ExtEffect, Machines: FeatureMachines>(
        _ machines: Machines
    ) -> Feature<Machines.Trigger, Event, Event, ExtEffect, Message> where Machines.Effect == Event, Machines.Message == Message {
        asIntEffectExtTrigger().asFeature(machines)
    }

    func asIntTriggerExtEffect<ExtTrigger, Machines: FeatureMachines>(
        _ machines: Machines
    ) -> Feature<Event, Machines.Effect, ExtTrigger, Event, Message> where Machines.Trigger == Event, Machines.Message == Message {
        asIntTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect, Machines: FeatureMachines>(
        _ machines: Machines
    ) -> Feature<Event, Event, ExtTrigger, ExtEffect, Message> where Machines.Trigger == Event, Machines.Effect == Event, Machines.Message == Message {
        asIntTriggerIntEffect().asFeature(machines)
    }

    func asIntEffectExtTriggerExtEffect<Machines: FeatureMachines>(
        _ machines: Machines
    ) -> Feature<Machines.Trigger, Event, Event, Event, Message> where Machines.Effect == Event, Machines.Message == Message {
        asIntEffectExtTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtEffect<ExtTrigger, Machines: FeatureMachines>(
        _ machines: Machines
    ) -> Feature<Event, Event, ExtTrigger, Event, Message> where Machines.Trigger == Event, Machines.Effect == Event, Machines.Message == Message {
        asIntTriggerIntEffectExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtTrigger<ExtEffect, Machines: FeatureMachines>(
        _ machines: Machines
    ) -> Feature<Event, Event, Event, ExtEffect, Message> where Machines.Trigger == Event, Machines.Effect == Event, Machines.Message == Message {
        asIntTriggerIntEffectExtTrigger().asFeature(machines)
    }

    func asIntTriggerExtTriggerExtEffect<Machines: FeatureMachines>(
        _ machines: Machines
    ) -> Feature<Event, Machines.Effect, Event, Event, Message> where Machines.Trigger == Event, Machines.Effect == Event, Machines.Message == Message {
        asIntTriggerExtTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtTriggerExtEffect<Machines: FeatureMachines>(
        _ machines: Machines
    ) -> Feature<Event, Event, Event, Event, Message> where Machines.Trigger == Event, Machines.Effect == Event, Machines.Message == Message {
        asIntTriggerIntEffectExtTriggerExtEffect().asFeature(machines)
    }
}
